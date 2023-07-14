
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/requests/filtered_cocktails_request.dart';
import 'package:cocktail_app/src/domain/repositories/api_repository.dart';
import 'package:cocktail_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:cocktail_app/src/utils/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_drinks_state.dart';

class RemoteDrinksCubit extends BaseCubit<RemoteDrinksState, List<Drink>> {
  final ApiRepository _apiRepository;

  RemoteDrinksCubit(this._apiRepository) : super(const RemoteDrinksLoading(), []);

  Future<void> getFilteredCocktails({Map<String, dynamic> filters = const {}}) async {
    if (isBusy) return;

    await run(() async {
      final response =
      await _apiRepository.getFilteredCocktails( request:
        FilteredCocktailsRequest(ingredients: filters["ingredients"])
      );

      if (response is DataSuccess) {
        // log("RES : " + response.data.toString());
        final drinks = response.data!.drinks;
        final noMoreData = drinks.isEmpty;

        data.addAll(drinks);

        emit(RemoteDrinksSuccess(drinks: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        // log(response.exception.toString());
      }
    });
  }
}
