part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {

  final DioException? exception;

  const SignupState({this.exception});

  @override
  List<Object?> get props => [];
}

class SignupLoading extends SignupState {
  const SignupLoading();
}

class SignupSuccess extends SignupState {
  const SignupSuccess();
}

class SignupFailed extends SignupState {
  const SignupFailed({super.exception});
}