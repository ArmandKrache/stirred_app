import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/presentation/views/drink_details_view.dart';
import 'package:cocktail_app/src/presentation/views/homepage_view.dart';
import 'package:cocktail_app/src/presentation/views/article_details_view.dart';
import 'package:cocktail_app/src/presentation/views/saved_articles_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:cocktail_app/src/domain/models/article.dart';
part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {

    @override
    List<AutoRoute> get routes => [
        AutoRoute(page: HomepageRoute.page, initial: true),
        AutoRoute(page: ArticleDetailsRoute.page),
        AutoRoute(page: SavedArticlesRoute.page),
        AutoRoute(page: DrinkDetailsRoute.page)
    ];
}

final appRouter = AppRouter();