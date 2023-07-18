import 'package:cocktail_app/src/domain/models/drink.dart';

abstract class DatabaseRepository {
  Future<List<Drink>> getSavedDrinks();

  Future<void> saveDrink(Drink drink);

  Future<void> removeDrink(Drink drink);

  Future<List<Drink>> findElementsById(String drinkId);
}