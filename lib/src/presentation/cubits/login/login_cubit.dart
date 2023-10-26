import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, Map<String, dynamic>> {
  final ApiRepository _apiRepository;

  LoginCubit(this._apiRepository) : super(const LoginLoading(), {});

  Future<void> isAlreadyLoggedIn() async {
    final access = await getAccessToken();
    final refresh = await getRefreshToken();
    logger.d("Access : $access | Refresh : $refresh");

    if (access == null || refresh == null) {
      emit(const LoginFailed());
      return ;
    }

    final refreshResponse = await _apiRepository.refreshToken(refreshToken: refresh);
    if (refreshResponse is DataSuccess) {
      await storeAccessToken(refreshResponse.data!.access);

      await _getProfile();
      appRouter.push(const RootRoute());
      emit(const LoginSuccess());
    } else {
      emit(const LoginFailed());
      return;
    }
  }

  Future<void> logIn({LoginRequest? request}) async {
    if (isBusy) return;
    if (request == null) return;

      await run(() async {
        final response = await _apiRepository.getTokens(request: request);
        if (response is DataSuccess) {
          final access = response.data!.access;
          final refresh = response.data!.refresh;

          await storeAccessToken(access);
          await storeRefreshToken(refresh);

          await _getProfile();
          appRouter.push(const RootRoute());
        } else if (response is DataFailed) {
          logger.d(response.exception!.error.toString());
          emit(const LoginLoading());
          emit(LoginFailed(exception: response.exception));
          /// TODO: display error toast
        }
      });
  }

  Future<void> _getProfile() async {
    final response = await _apiRepository.getSelfProfile();
    if (response is DataSuccess) {
      logger.d(response.data);
      currentProfile = response.data!;
      emit(const LoginSuccess());
      appRouter.push(const RootRoute());
    } else if (response is DataFailed) {
      logger.d(response.exception!.error.toString());
      emit(const LoginLoading());
      emit(LoginFailed(exception: response.exception));
      /// TODO: display error toast
    }
    return;
  }
}
