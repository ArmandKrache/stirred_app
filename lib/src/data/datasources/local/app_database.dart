import 'package:cocktail_app/src/data/datasources/local/converters/source_type_converter.dart';
import 'package:cocktail_app/src/data/datasources/local/dao/drink_dao.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/domain/models/drink.dart';
import 'package:cocktail_app/src/domain/models/source.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version : 1, entities: [Drink])
abstract class AppDatabase extends FloorDatabase {
  DrinkDao get drinkDao;
}