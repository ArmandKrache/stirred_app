part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  final DioException? exception;

  const ProfileState({
    this.exception,
  });

  @override
  List<Object?> get props => [exception];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess();
}

class ProfileFailed extends ProfileState {
  const ProfileFailed({super.exception});
}