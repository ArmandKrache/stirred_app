part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {

  final Profile? profile;
  final DioException? exception;

  const SignupState({this.profile, this.exception});

  @override
  List<Object?> get props => [];
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupSuccess extends SignupState {
  const SignupSuccess({super.profile});
}

class SignupFailed extends SignupState {
  const SignupFailed({super.exception});
}

class SignupUsernameValidityLoading extends SignupState {
  const SignupUsernameValidityLoading();
}

class SignupUsernameValiditySuccess extends SignupState {
  const SignupUsernameValiditySuccess();
}

class SignupUsernameValidityFailed extends SignupState {
  const SignupUsernameValidityFailed();
}
