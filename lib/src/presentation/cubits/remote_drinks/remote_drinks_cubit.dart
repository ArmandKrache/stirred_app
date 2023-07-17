
import 'dart:developer';

import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/requests/filtered_cocktails_request.dart';
import 'package:cocktail_app/src/domain/models/requests/searched_cocktails_request.dart';
import 'package:cocktail_app/src/domain/repositories/api_repository.dart';
import 'package:cocktail_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:cocktail_app/src/utils/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_drinks_state.dart';

class RemoteDrinksCubit extends BaseCubit<RemoteDrinksState, List<Drink>> {
  final ApiRepository _apiRepository;

  RemoteDrinksCubit(this._apiRepository) : super(const RemoteDrinksLoading(), []);

  Future<void> handleEvent({dynamic event}) async {
    if (isBusy) return;
    log("EVENT : ${event.toString()}");
    if (event == null) return;


    if (event is FilteredDrinksEvent) {
      await run(() async {
        final response =
          await _apiRepository.getFilteredCocktails(request: event.request!);

        if (response is DataSuccess) {
          final drinks = response.data!.drinks;
          final noMoreData = drinks.isEmpty;

          data.addAll(drinks);

          emit(RemoteDrinksSuccess(drinks: data, noMoreData: noMoreData));
        } else if (response is DataFailed) {
          log(response.exception.toString());
        }
      });
    } else if (event is SearchDrinksEvent) {
      await run(() async {
        emit(RemoteDrinksLoading());
        final response = await _apiRepository.getSearchedCocktails(request: event.request!);

        if (response is DataSuccess) {
          final drinks = response.data!.drinks;
          final noMoreData = drinks.isEmpty;

          data.clear();
          data.addAll(drinks);

          emit(RemoteDrinksSuccess(drinks: data, noMoreData: noMoreData));
        } else if (response is DataFailed) {
          // log(response.exception.toString());
        }
      });
    }
  }
}

class SearchDrinksEvent {
  final SearchedCocktailsRequest? request;

  SearchDrinksEvent({this.request});
}

class FilteredDrinksEvent {
  final FilteredCocktailsRequest? request;

  FilteredDrinksEvent({this.request});
}