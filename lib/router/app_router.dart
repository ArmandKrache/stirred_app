import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/presentation_old/views/login_view.dart';
import 'package:stirred_app/presentation_old/views/homepage.dart';
import 'package:stirred_app/presentation_old/views/drink.dart';
import 'package:stirred_app/presentation_old/views/signup/signup.dart';
import 'package:stirred_app/presentation_old/views/profile/profile.dart';
import 'package:stirred_app/presentation_old/views/profile/profile_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:stirred_app/presentation_old/views/root_view.dart';

part 'app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {

    @override
    List<AutoRoute> get routes => [
        AutoRoute(page: RootRoute.page,),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: SignupRoute.page,),
        AutoRoute(page: HomepageRoute.page,),
        AutoRoute(page: DrinkRoute.page,),
        AutoRoute(page: ProfileRoute.page,),
        AutoRoute(page: ProfileEditRoute.page,),
    ];
}

final appRouter = AppRouter();