import 'dart:developer';

import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends BaseCubit<SignupState, Profile?> {
  final ApiRepository _apiRepository;
  final debouncer = Debouncer(milliseconds: 700);


  SignupCubit(this._apiRepository) : super(const SignupLoading(), null);

  Future<void> checkUsernameValidity({required String username}) async {
    if (isBusy) return ;
    if (username == "") {
      emit(const SignupLoading());
      return;
    }

    const SignupUsernameValidityLoading();
    debouncer.debounce(() async {
      final response = await _apiRepository.checkUsernameValidity(username: username);
      if (response is DataSuccess) {

        emit(const SignupUsernameValiditySuccess());
      } else if (response is DataFailed) {
        emit(const SignupUsernameValidityFailed());
      }
    });
    return;
  }

  Future<Profile?> signup({required SignupRequest userRequest, required ProfileCreateRequest profileRequest}) async {
    if (isBusy) return null;

      final response = await _apiRepository.signup(request: userRequest);
      if (response is DataSuccess) {
        final access = response.data!.access;
        final refresh = response.data!.refresh;

        await storeAccessToken(access);
        await storeRefreshToken(refresh);

        Profile? newProfile = await createProfile(request: profileRequest);
        if (newProfile != null) {
          emit(const SignupSuccess());
          return newProfile;
        }
      } else if (response is DataFailed) {
        logger.d(response.exception!.error.toString());
        emit(SignupFailed(exception: response.exception));
        /// TODO: display error toast
      }
      return null;
  }

  Future<Profile?> createProfile({required ProfileCreateRequest request}) async {
    if (isBusy) return null;

      final response = await _apiRepository.createProfile(request: request);
      if (response is DataSuccess) {

        data = response.data!.profile;
        currentProfile = response.data!.profile;
        appRouter.push(const RootRoute());
        return response.data!.profile;
      } else if (response is DataFailed) {
        logger.d(response.exception!.error.toString());
        emit(SignupFailed(exception: response.exception));
        /// TODO: display error toast
      }
      return null;
  }


}
