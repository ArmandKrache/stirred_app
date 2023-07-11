import 'package:template_app/src/data/datasources/local/converters/source_type_converter.dart';
import 'package:template_app/src/data/datasources/local/dao/articles_dao.dart';
import 'package:template_app/src/domain/models/article.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version : 1, entities: [Article])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}