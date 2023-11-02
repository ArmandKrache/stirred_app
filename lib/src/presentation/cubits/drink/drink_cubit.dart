import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'drink_state.dart';

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

  Future<bool> favoriteAction({required String drinkId, bool isFavorite = false}) async {
    if (isBusy) return false;

    DataState<dynamic> response =
     await _apiRepository.favoriteAction(drinkId: drinkId);
    if (response is DataSuccess) {
      final res = response.data!;
      if (isFavorite) {
        currentProfile.preferences.favorites.removeWhere((element) => element.id == drinkId);
      } else {
        currentProfile.preferences.favorites.add(GenericPreviewDataModel(id: drinkId));
      }

      return true;
    } else if (response is DataFailed) {
      log(response.exception.toString());
    }
    return false;
  }

}