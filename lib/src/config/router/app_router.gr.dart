// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ArticleDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArticleDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ArticleDetailsView(
          key: args.key,
          article: args.article,
        ),
      );
    },
    SavedArticlesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SavedArticlesView(),
      );
    },
    HomepageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomepageView(),
      );
    },
    DrinkDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DrinkDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DrinkDetailsView(
          key: args.key,
          drinkId: args.drinkId,
        ),
      );
    },
  };
}

/// generated route for
/// [ArticleDetailsView]
class ArticleDetailsRoute extends PageRouteInfo<ArticleDetailsRouteArgs> {
  ArticleDetailsRoute({
    Key? key,
    required Article article,
    List<PageRouteInfo>? children,
  }) : super(
          ArticleDetailsRoute.name,
          args: ArticleDetailsRouteArgs(
            key: key,
            article: article,
          ),
          initialChildren: children,
        );

  static const String name = 'ArticleDetailsRoute';

  static const PageInfo<ArticleDetailsRouteArgs> page =
      PageInfo<ArticleDetailsRouteArgs>(name);
}

class ArticleDetailsRouteArgs {
  const ArticleDetailsRouteArgs({
    this.key,
    required this.article,
  });

  final Key? key;

  final Article article;

  @override
  String toString() {
    return 'ArticleDetailsRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [SavedArticlesView]
class SavedArticlesRoute extends PageRouteInfo<void> {
  const SavedArticlesRoute({List<PageRouteInfo>? children})
      : super(
          SavedArticlesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SavedArticlesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomepageView]
class HomepageRoute extends PageRouteInfo<void> {
  const HomepageRoute({List<PageRouteInfo>? children})
      : super(
          HomepageRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomepageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DrinkDetailsView]
class DrinkDetailsRoute extends PageRouteInfo<DrinkDetailsRouteArgs> {
  DrinkDetailsRoute({
    Key? key,
    required String? drinkId,
    List<PageRouteInfo>? children,
  }) : super(
          DrinkDetailsRoute.name,
          args: DrinkDetailsRouteArgs(
            key: key,
            drinkId: drinkId,
          ),
          initialChildren: children,
        );

  static const String name = 'DrinkDetailsRoute';

  static const PageInfo<DrinkDetailsRouteArgs> page =
      PageInfo<DrinkDetailsRouteArgs>(name);
}

class DrinkDetailsRouteArgs {
  const DrinkDetailsRouteArgs({
    this.key,
    required this.drinkId,
  });

  final Key? key;

  final String? drinkId;

  @override
  String toString() {
    return 'DrinkDetailsRouteArgs{key: $key, drinkId: $drinkId}';
  }
}
