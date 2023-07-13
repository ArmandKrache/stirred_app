import 'package:cocktail_app/src/data/datasources/remote/base/base_api_repository.dart';
import 'package:cocktail_app/src/data/datasources/remote/cocktail_api_service.dart';
import 'package:cocktail_app/src/domain/models/requests/filtered_cocktails_request.dart';
import 'package:cocktail_app/src/domain/models/requests/lookup_details_request.dart';
import 'package:cocktail_app/src/domain/models/requests/popular_cocktails_request.dart';
import 'package:cocktail_app/src/domain/models/responses/filtered_cocktails_response.dart';
import 'package:cocktail_app/src/domain/models/responses/lookup_details_response.dart';
import 'package:cocktail_app/src/domain/models/responses/popular_cocktails_response.dart';
import 'package:cocktail_app/src/domain/repositories/api_repository.dart';
import 'package:cocktail_app/src/utils/resources/data_state.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final CocktailApiService _cocktailApiService;

  ApiRepositoryImpl(this._cocktailApiService);

  @override
  Future<DataState<PopularCocktailsResponse>> getPopularCocktails({
    required PopularCocktailsRequest request
  }) {
    return getState0f<PopularCocktailsResponse>(request: () => _cocktailApiService.getPopularCocktails());
  }

  @override
  Future<DataState<FilteredCocktailsResponse>> getFilteredCocktails({
    required FilteredCocktailsRequest request
  }) {
    return getState0f<FilteredCocktailsResponse>(request: () => _cocktailApiService.getFilteredCocktails(
      alcoholic: request.alcoholic,
      ingredients: request.ingredients,
      glass: request.glass,
      categorie: request.categorie
    ));
  }

  @override
  Future<DataState<LookupDetailsResponse>> lookupDetails({
    required LookupDetailsRequest request
  }) {
    return getState0f<LookupDetailsResponse>(request: () => _cocktailApiService.lookupDetails(
      drinkId: request.drinkId,
      ingredientId: request.ingredientId,
    ));
  }
}