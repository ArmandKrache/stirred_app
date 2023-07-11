import 'package:cocktail_app/src/domain/models/article.dart';
import 'package:cocktail_app/src/utils/constants/strings.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {
  @Query('SELECT * FROM $articlesTableName')
  Future<List<Article>>getAllArticles();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertArticle(Article article);

  @delete
  Future<void> deleteArticle(Article article);
}