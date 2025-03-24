import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'drink_state.dart';

final drinkCubitProvider = Provider.autoDispose<DrinkCubit>((ref) {
  final apiRepository = ref.watch(apiRepositoryProvider);
  return DrinkCubit(apiRepository);
});

class DrinkCubit extends BaseCubit<DrinkState, Drink?> {
  final ApiRepository _apiRepository;

  DrinkCubit(this._apiRepository) : super(const DrinkLoading(), null);

  Future<void> retrieveDrink({required String id}) async {
    if (isBusy) return;

    await run(() async {
      emit(const DrinkLoading());
      late DataState<Drink> response;
      response = await _apiRepository.retrieveDrink(request: DrinkRetrieveRequest(id: id));

      if (response is DataSuccess) {
        final drink = response.data!;

        data = drink;

        emit(DrinkSuccess(drink: data));
      } else if (response is DataFailed) {
        log(response.exception.toString());
        emit(DrinkFailed(exception: response.exception));
      }
    });
  }

  Future<Rating?> rateDrink({required RatingCreateRequest request, String ratingId = ""}) async {
    if (isBusy) return null;

    DataState<RatingCreateResponse> response =
      await _apiRepository.createRating(request: request);
    if (response is DataSuccess) {
      final res = response.data!.rating;
      logger.d(res);
      return res;
    } else if (response is DataFailed) {
      log(response.exception.toString());
    }
    return null;
  }

  Future<Rating?> patchDrinkRating({required RatingPatchRequest request}) async {
    if (isBusy) return null;

    DataState<RatingPatchResponse> response =
      await _apiRepository.patchRating(request: request);
    if (response is DataSuccess) {
      final res = response.data!.rating;

      return res;
    } else if (response is DataFailed) {
      log(response.exception.toString());
    }
    return null;
  }

  Future<bool> favoriteAction({required Drink drink, bool isFavorite = false}) async {
    final response = await _apiRepository.favoriteAction(drinkId: drink.id);
    if (response is DataSuccess) {
      return true;
    } else if (response is DataFailed) {
      log('Failed to toggle favorite: ${response.exception}');
    }
    return false;
  }
}