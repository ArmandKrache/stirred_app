import 'package:stirred_app/router/app_router.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/presentation/cubits/profile/profile_cubit.dart';

part 'login_state.dart';

final loginCubitProvider = Provider.autoDispose<LoginCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  final tokenManager = ref.watch(tokenManagerProvider.notifier);
  return LoginCubit(apiRepository, tokenManager, ref);
});

class LoginCubit extends Cubit<LoginState> {
  final ApiRepository _apiRepository;
  final TokenManager _tokenManager;
  final ProviderRef _ref;

  LoginCubit(this._apiRepository, this._tokenManager, this._ref) : super(const LoginLoading());

  Future<void> isAlreadyLoggedIn() async {
    final header = await _tokenManager.getAuthorizationHeader();
    if (header == null) {
      emit(const LoginFailed());
      return;
    }

    final refreshed = await _tokenManager.refreshTokens();
    if (refreshed) {
      await _getProfileAndDispatch();
      emit(const LoginSuccess());
    } else {
      emit(const LoginFailed());
      return;
    }
  }

  Future<void> logIn({LoginRequest? request}) async {
    if (request == null) return;

    emit(const LoginLoading());
    final response = await _apiRepository.getTokens(request: request);
    
    if (response is DataSuccess) {
      final access = response.data!.access;
      final refresh = response.data!.refresh;

      await _tokenManager.storeTokens(accessToken: access, refreshToken: refresh);
      await _getProfileAndDispatch();
    } else if (response is DataFailed) {
      logger.d(response.exception.toString());
      emit(LoginFailed(exception: response.exception));
    }
  }

  Future<void> _getProfileAndDispatch() async {
    final response = await _apiRepository.getSelfProfile();
    if (response is DataSuccess) {
      final profileCubit = _ref.read(profileCubitProvider);
      profileCubit.emit(ProfileLoaded(profile: response.data!));
      emit(const LoginSuccess());
      appRouter.push(const RootRoute());
    } else if (response is DataFailed) {
      logger.d(response.exception.toString());
      emit(LoginFailed(exception: response.exception));
    }
  }
}
