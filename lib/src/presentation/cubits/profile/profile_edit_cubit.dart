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

  Future<void> doSomething() async {
    if (isBusy) return;

    await run(() async {
      emit(const ProfileEditLoading());
      emit(const ProfileEditSuccess());
    });
  }

}