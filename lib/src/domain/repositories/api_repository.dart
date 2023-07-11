import 'package:cocktail_app/src/domain/models/requests/breaking_news_request.dart';
import 'package:cocktail_app/src/domain/models/responses/breaking_news_response.dart';
import 'package:cocktail_app/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request,
  });
}