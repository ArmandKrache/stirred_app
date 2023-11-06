import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'profile_edit_state.dart';


class ProfileEditCubit extends BaseCubit<ProfileEditState, Profile> {
  final ApiRepository _apiRepository;

  ProfileEditCubit(this._apiRepository) : super(const ProfileEditSuccess(), currentProfile);

  Future<Profile?> patchProfile(String id, Map<String, dynamic> data) async {
    if (isBusy) return null;

    emit(const ProfileEditLoading());
    ProfilePatchRequest patchRequest = ProfilePatchRequest(
      id: id,
      name: data["name"],
      description: data["description"],
      picture: data["picture"],
      birthdate: data["birthdate"]
    );

    DataState<ProfilePatchResponse> response =
      await _apiRepository.patchProfile(request: patchRequest);
    if (response is DataSuccess) {
      final res = response.data!.profile;
      currentProfile = res;

      emit(const ProfileEditSuccess());
      return res;
    } else if (response is DataFailed) {
      log(response.exception.toString());
      emit(const ProfileEditFailed());
    }
    return null;
  }

}