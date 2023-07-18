import 'package:cocktail_app/src/data/datasources/local/app_database.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/repositories/database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final AppDatabase _appDatabase;

  DatabaseRepositoryImpl(this._appDatabase);

  @override
  Future<List<Drink>> getSavedDrinks() async {
    return _appDatabase.drinkDao.getAllDrinks();
  }

  @override
  Future<void> removeDrink(Drink drink) async {
    return _appDatabase.drinkDao.deleteDrink(drink);
  }

  @override
  Future<void> saveDrink(Drink drink) async {
    return _appDatabase.drinkDao.insertDrink(drink);
  }

  @override
  Future<List<Drink>> findElementsById(String drinkId) async {
    return _appDatabase.drinkDao.findElementById(drinkId);
  }
}