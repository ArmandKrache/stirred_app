part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  final Profile? profile;
  final DioException? exception;

  const ProfileState({
    this.profile,
    this.exception,
  });

  @override
  List<Object?> get props => [profile, exception];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  const ProfileSuccess({super.profile});
}

class ProfileFailed extends ProfileState {
  const ProfileFailed({super.exception});
}