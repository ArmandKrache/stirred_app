import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'profile_state.dart';

final profileCubitProvider = Provider.autoDispose<ProfileCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  final tokenManager = ref.watch(tokenManagerProvider.notifier);
  return ProfileCubit(apiRepository, tokenManager);
});

class ProfileCubit extends Cubit<ProfileState> {
  final ApiRepository _apiRepository;
  final TokenManager _tokenManager;

  ProfileCubit(this._apiRepository, this._tokenManager) : super(const ProfileLoading());

  void rebuild() {
    if (state is ProfileLoaded) {
      emit(state);
    }
  }

  Future<void> logOut() async {
    await _tokenManager.clearTokens();
    appRouter.popUntil((route) => route.data?.name == "LoginRoute");
  }

  Future<void> loadProfile() async {
    if (state is ProfileLoading) return;
    
    emit(const ProfileLoading());

    final response = await _apiRepository.getSelfProfile();

    if (response is DataSuccess) {
      emit(ProfileLoaded(profile: response.data!));
    } else if (response is DataFailed) {
      emit(ProfileError(exception: response.exception!));
    }
  }

  void updateFavorites(Drink drink, bool isFavorite) {
    if (state is! ProfileLoaded) return;
    
    final currentState = state as ProfileLoaded;
    final updatedProfile = currentState.profile;
    
    if (isFavorite) {
      updatedProfile.preferences.favorites.removeWhere((element) => element.id == drink.id);
    } else {
      updatedProfile.preferences.favorites.add(GenericPreviewDataModel(
        id: drink.id,
        name: drink.name,
        picture: drink.picture,
        description: drink.description,
      ));
    }
    
    emit(ProfileLoaded(profile: updatedProfile));
  }
}
