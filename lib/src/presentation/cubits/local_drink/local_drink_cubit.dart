import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/repositories/database_repository.dart';
import 'package:equatable/equatable.dart';

part 'local_drink_state.dart';

class LocalDrinkCubit extends Cubit<LocalDrinkState> {
  final DatabaseRepository _databaseRepository;
  bool isFavorite = false;

  LocalDrinkCubit(this._databaseRepository) :
      super(const LocalDrinkLoading());

  Future<void> getAllSavedDrink() async {
    emit(await _getAllSavedDrinks());
  }

  Future<void> removeDrink({required Drink drink}) async {
    await _databaseRepository.removeDrink(drink);
    emit(await _getAllSavedDrinks());
  }

  Future<void> saveDrink({required Drink drink}) async {
    await _databaseRepository.saveDrink(drink);
    isFavorite = true;
    emit(await _getAllSavedDrinks());
  }

  Future<void> contains({required Drink drink}) async {
    if (drink.idDrink == null) {
      isFavorite = false;
    } else {
      List<Drink> res = await _databaseRepository.findElementsById(drink.idDrink!);
      isFavorite = res.isNotEmpty;
    }
    return emit(await _getAllSavedDrinks());
  }

  Future<LocalDrinkState> _getAllSavedDrinks() async {
    final drinkList = await _databaseRepository.getSavedDrinks();
    return LocalDrinkSuccess(drinkList: drinkList);
  }
}
