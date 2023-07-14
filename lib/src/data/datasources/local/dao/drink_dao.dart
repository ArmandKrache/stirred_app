import 'package:cocktail_app/src/config/config.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:floor/floor.dart';

@dao
abstract class DrinkDao {
  @Query('SELECT * FROM $drinkTableName')
  Future<List<Drink>>getAllDrinks();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDrink(Drink drink);

  @delete
  Future<void> deleteDrink(Drink drink);
}