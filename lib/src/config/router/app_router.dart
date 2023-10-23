import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/presentation/views/login_view.dart';
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
    ];
}

final appRouter = AppRouter();