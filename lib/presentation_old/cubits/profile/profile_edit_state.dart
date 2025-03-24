part of 'profile_edit_cubit.dart';

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object?> get props => [];
}

class ProfileEditLoading extends ProfileEditState {
  const ProfileEditLoading();
}

class ProfileEditSuccess extends ProfileEditState {
  const ProfileEditSuccess();
}

class ProfileEditFailed extends ProfileEditState {
  final Exception? exception;
  
  const ProfileEditFailed({this.exception});
  
  @override
  List<Object?> get props => [exception];
} 