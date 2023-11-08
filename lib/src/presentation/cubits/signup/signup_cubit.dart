import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends BaseCubit<SignupState, Map<String, dynamic>> {
  final ApiRepository _apiRepository;

  SignupCubit(this._apiRepository) : super(const SignupLoading(), {});

  /*
  Future<void> Signup({SignupRequest? request}) async {
    if (isBusy) return;
    if (request == null) return;

      await run(() async {
        final response = await _apiRepository.signup(request: request);
        if (response is DataSuccess) {

          _getProfileAndDispatch();
        } else if (response is DataFailed) {
          logger.d(response.exception!.error.toString());
          emit(const SignupLoading());
          emit(SignupFailed(exception: response.exception));
          /// TODO: display error toast
        }
      });
  }*/
}
