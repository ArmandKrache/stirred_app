import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

part 'homepage_state.dart';

class HomepageCubit extends BaseCubit<HomepageState, List<Drink>> {
  final ApiRepository _apiRepository;

  HomepageCubit(this._apiRepository) : super(const HomepageLoading(), []);

  Future<void> fetchDrinksList({String query = ""}) async {
    if (isBusy) return;

    await run(() async {
      emit(DrinksListLoading(drinks: data));
      late DataState<DrinksListResponse> response;
      if (query == "") {
        response = await _apiRepository.getDrinksList(request: DrinksListRequest());
      } else {
        response = await _apiRepository.searchDrinks(request: DrinksSearchRequest(query: query));
      }

      if (response is DataSuccess) {
        final drinks = response.data!.drinks;
        final noMoreData = drinks.isEmpty;

        data.clear();
        data.addAll(drinks);

        emit(DrinksListSuccess(drinks: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        log(response.exception.toString());
      }
    });
  }

}