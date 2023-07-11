import 'package:template_app/src/data/datasources/local/app_database.dart';
import 'package:template_app/src/data/datasources/remote/news_api_service.dart';
import 'package:template_app/src/data/repositories/api_repository_impl.dart';
import 'package:template_app/src/data/repositories/database_repository_impl.dart';
import 'package:template_app/src/domain/repositories/api_repository.dart';
import 'package:template_app/src/domain/repositories/database_repository.dart';
import 'package:template_app/src/utils/constants/strings.dart';
import 'package:dio/dio.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies ( ) async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<AppDatabase>())
  );

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<NewsApiService>(
    NewsApiService(locator<Dio>()),
  );
  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<NewsApiService>()),
  );
 }