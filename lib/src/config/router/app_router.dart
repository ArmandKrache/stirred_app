import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/presentation/views/login_view.dart';
import 'package:stirred_app/src/presentation/views/homepage.dart';
import 'package:stirred_app/src/presentation/views/drink.dart';
import 'package:stirred_app/src/presentation/views/profile/profile.dart';
import 'package:stirred_app/src/presentation/views/profile/profile_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:stirred_app/src/presentation/views/root_view.dart';
part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {

    @override
    List<AutoRoute> get routes => [
        AutoRoute(page: RootRoute.page,),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: HomepageRoute.page,),
        AutoRoute(page: DrinkRoute.page,),
        AutoRoute(page: ProfileRoute.page,),
        AutoRoute(page: ProfileEditRoute.page,),
    ];
}

final appRouter = AppRouter();