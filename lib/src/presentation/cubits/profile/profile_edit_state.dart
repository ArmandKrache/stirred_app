part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  final DioException? exception;

  const ProfileEditState({
    this.exception,
  });

  @override
  List<Object?> get props => [exception];
}

class ProfileEditLoading extends ProfileEditState {
  const ProfileEditLoading();
}

class ProfileEditSuccess extends ProfileEditState {
  const ProfileEditSuccess();
}

class ProfileEditFailed extends ProfileEditState {
  const ProfileEditFailed({super.exception});
}