import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_cubit.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'homepage_state.dart';

final homepageCubitProvider = Provider.autoDispose<HomepageCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  final cubit = HomepageCubit(apiRepository, ref);
  cubit.fetchDrinksList();
  return cubit;
});

class HomepageCubit extends Cubit<HomepageState> {
  final ApiRepository _apiRepository;
  final ProviderRef _ref;

  HomepageCubit(this._apiRepository, this._ref) : super(const HomepageLoading(drinks: []));

  Future<void> fetchDrinksList({String? query}) async {
    if (state is HomepageLoading) return;

    emit(HomepageLoading(drinks: state.drinks));

    DataState<DrinksListResponse> response;
    if (query != null && query.isNotEmpty) {
      response = await _apiRepository.searchDrinks(request: DrinksSearchRequest(query: query));
    } else {
      response = await _apiRepository.getDrinksList(request: DrinksListRequest());
    }

    if (response is DataSuccess) {
      emit(HomepageSuccess(drinks: response.data!.drinks));
    } else if (response is DataFailed) {
      emit(HomepageError(drinks: state.drinks, exception: response.exception));
    }
  }

  void rebuild() {
    if (state is HomepageSuccess) {
      emit(HomepageSuccess(drinks: state.drinks));
    }
  }

  Future<void> toggleFavorite({required String drinkId}) async {
    if (state is HomepageLoading) return;

    final drink = state.drinks.firstWhere((d) => d.id == drinkId);
    final profileCubit = _ref.read(profileCubitProvider);
    final isFavorite = profileCubit.state is ProfileLoaded
        ? (profileCubit.state as ProfileLoaded).profile.preferences.favorites.any((f) => f.id == drinkId)
        : false;

    final response = await _apiRepository.favoriteAction(drinkId: drinkId);
    if (response is DataSuccess) {
      profileCubit.updateFavorites(drink, isFavorite);
    } else if (response is DataFailed) {
      log('Failed to toggle favorite: ${response.exception}');
    }
  }
}