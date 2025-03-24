import 'package:stirred_app/router/app_router.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/presentation_old/cubits/profile/profile_cubit.dart';

part 'signup_state.dart';

final signupCubitProvider = Provider.autoDispose<SignupCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  final tokenManager = ref.watch(tokenManagerProvider.notifier);
  return SignupCubit(apiRepository, tokenManager, ref);
});

class SignupCubit extends Cubit<SignupState> {
  final ApiRepository _apiRepository;
  final TokenManager _tokenManager;
  final ProviderRef _ref;
  final debouncer = Debouncer(milliseconds: 700);

  SignupCubit(this._apiRepository, this._tokenManager, this._ref) : super(const SignupLoading());

  Future<void> checkUsernameValidity({required String username, required Function(bool) onFinishCallback}) async {
    if (username == "") {
      emit(const SignupLoading());
      return;
    }

    emit(const SignupUsernameValidityLoading());
    await debouncer.debounce(() async {
      bool res = false;
      final response = await _apiRepository.checkUsernameValidity(username: username);
      if (response is DataSuccess) {
        res = true;
        emit(const SignupUsernameValiditySuccess());
      } else if (response is DataFailed) {
        res = false;
        emit(const SignupUsernameValidityFailed());
      }
      onFinishCallback.call(res);
    });
  }

  Future<Profile?> signup({required SignupRequest userRequest, required ProfileCreateRequest profileRequest}) async {
    final response = await _apiRepository.signup(request: userRequest);
    if (response is DataSuccess) {
      final access = response.data!.access;
      final refresh = response.data!.refresh;

      await _tokenManager.storeTokens(accessToken: access, refreshToken: refresh);

      Profile? newProfile = await createProfile(request: profileRequest);
      if (newProfile != null) {
        emit(const SignupSuccess());
        return newProfile;
      }
    } else if (response is DataFailed) {
      logger.d(response.exception.toString());
      emit(SignupFailed(exception: response.exception));
    }
    return null;
  }

  Future<Profile?> createProfile({required ProfileCreateRequest request}) async {
    final response = await _apiRepository.createProfile(request: request);
    if (response is DataSuccess) {
      final profileCubit = _ref.read(profileCubitProvider);
      profileCubit.emit(ProfileLoaded(profile: response.data!.profile));
      appRouter.push(const RootRoute());
      return response.data!.profile;
    } else if (response is DataFailed) {
      logger.d(response.exception.toString());
      emit(SignupFailed(exception: response.exception));
    }
    return null;
  }
}
