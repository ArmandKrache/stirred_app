import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/drink_details.dart';

abstract class DatabaseRepository {
  Future<List<Drink>> getSavedDrinks();

  Future<void> saveDrink(Drink drink);

  Future<void> removeDrink(Drink drink);
}