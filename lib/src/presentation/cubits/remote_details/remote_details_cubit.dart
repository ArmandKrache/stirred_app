import 'dart:developer';

import 'package:cocktail_app/src/domain/models/drink_details.dart';
import 'package:cocktail_app/src/domain/models/ingredient.dart';
import 'package:cocktail_app/src/domain/models/requests/lookup_details_request.dart';
import 'package:cocktail_app/src/domain/repositories/api_repository.dart';
import 'package:cocktail_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:cocktail_app/src/utils/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'remote_details_state.dart';

class RemoteDetailsCubit extends BaseCubit<RemoteDetailsState, Map<String, dynamic>> {
  final ApiRepository _apiRepository;

  RemoteDetailsCubit(this._apiRepository,) : super(const RemoteDetailsLoading(), {
    "details" : <DrinkDetails>[],
    "ingredients" : <Ingredient>[]
  });

  Future<void> handleEvent(dynamic event) async {
    if (isBusy) return;

    if (event is LookupDetailsEvent) {

      await run(() async {
        final response =
        await _apiRepository.lookupDetails(request: LookupDetailsRequest(drinkId: event.drinkId, ingredientId: event.ingredientId));

        if (response is DataSuccess) {
          final details = response.data!.drinksDetails.isEmpty ? <DrinkDetails>[] : response.data!.drinksDetails;
          final ingredients = response.data!.ingredients.isEmpty ? <Ingredient>[] : response.data!.ingredients;


          data["details"].addAll(details);
          data["ingredients"].addAll(ingredients);

          emit(RemoteDetailsSuccess(drinksDetails:  List<DrinkDetails>.from(data["details"]),
              ingredients: List<Ingredient>.from(data["ingredients"])));
        } else if (response is DataFailed) {
          log(response.exception.toString());
        }
      });
    }
  }
}

class LookupDetailsEvent {
  final String? drinkId;
  final String? ingredientId;

  LookupDetailsEvent({this.drinkId, this.ingredientId});
}
