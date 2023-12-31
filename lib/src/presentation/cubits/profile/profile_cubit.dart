import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState, Profile> {
  final ApiRepository _apiRepository;

  ProfileCubit(this._apiRepository) : super(const ProfileSuccess(), currentProfile);

  Future<void> rebuild() async {
    emit(const ProfileLoading());
    data = currentProfile;
    emit(ProfileSuccess(profile: data));
  }

  Future<void> logOut() async {
    await deleteTokens();
    appRouter.popUntil((route) => route.data?.name == "LoginRoute");
  }

}