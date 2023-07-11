import 'package:cocktail_app/src/domain/models/responses/breaking_news_response.dart';
import 'package:cocktail_app/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<BreakingNewsResponse>> getBreakingNewsArticles({
    @Query("country") String? country,
    @Query("category") String? category,
    @Query("page") int? page,
    @Query("pageSize") int? pageSize,
    @Header("Authorization") String? authorization
  });
}