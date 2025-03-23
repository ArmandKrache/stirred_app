import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'profile_edit_state.dart';

final profileEditCubitProvider = Provider.autoDispose<ProfileEditCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  return ProfileEditCubit(apiRepository);
});

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final ApiRepository _apiRepository;

  ProfileEditCubit(this._apiRepository) : super(const ProfileEditLoading());

  Future<Profile?> patchProfile(String id, Map<String, dynamic> data) async {
    emit(const ProfileEditLoading());
    final patchRequest = ProfilePatchRequest(
      id: id,
      name: data["name"],
      description: data["description"],
      picture: data["picture"],
      birthdate: data["birthdate"]
    );
    final response = await _apiRepository.patchProfile(request: patchRequest);
    if (response is DataSuccess) {
      emit(const ProfileEditSuccess());
      return response.data!.profile;
    } else if (response is DataFailed) {
      emit(ProfileEditFailed(exception: response.exception));
    }
    return null;
  }
}
