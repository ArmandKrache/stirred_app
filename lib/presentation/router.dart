import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stirred_app/core/events/event_router_observer.dart';
import 'package:stirred_app/presentation/views/account/account_view.dart';
import 'package:stirred_app/presentation/views/account/profile_edit_view.dart';
import 'package:stirred_app/presentation/views/cellar/cellar_view.dart';
import 'package:stirred_app/presentation/views/creation/creation_view.dart';
import 'package:stirred_app/presentation/views/discovery/discovery_view.dart';
import 'package:stirred_app/presentation/views/drink_details/drink_details_view.dart';
import 'package:stirred_app/presentation/views/drinks/drinks.dart';
import 'package:stirred_app/presentation/views/home/home_view.dart';
import 'package:stirred_app/presentation/views/login/login_view.dart';
import 'package:stirred_app/presentation/views/signup/signup_view.dart';
import 'package:stirred_app/presentation/views/root.dart';
import 'package:stirred_app/presentation/widgets/error_placeholder.dart';
import 'package:stirred_app/presentation/widgets/tools/page_transitions.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _drinksNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'drinks');
final _discoveryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'discovery');
final _creationNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'creation');
final _cellarNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cellar');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

bool routerInitialized = false;
final EventGoRouterObserver routerEventObserver = EventGoRouterObserver();


final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: _RootRoute.route,
  observers: [routerEventObserver],
  errorPageBuilder: (context, state) {

    return MaterialPage<void>(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ErrorPlaceholder(
              message: 'Page Not found',
              error: state.error,
              action: () => context.go(HomeRoute.route(HomeTabConstants.defaultTabIndex)),
              actionLabel: 'Back to Home',
            ),
          ),
        ),
      ),
    );
  },
  routes: [
    _RootRoute(),
    LoginRoute(),
    SignupRoute(),
    HomeRoute(),
  ],
);

extension RouterExtensions on GoRouter {
  String get currentRoute => routeInformationProvider.value.uri.path;
}

class _RootRoute extends GoRoute {
  _RootRoute()
      : super(
          path: route,
          pageBuilder: (context, state) => const NoTransitionPage(child: RootView(),),
        );

  static const String route = '/';
}

class LoginRoute extends GoRoute {
  LoginRoute()
      : super(
          path: route,
          pageBuilder: (context, state) => const NoTransitionPage(child: LoginView(),),
        );

  static const String route = '/login';
}

class SignupRoute extends GoRoute {
  SignupRoute()
      : super(
          path: route,
          pageBuilder: (context, state) => const NoTransitionPage(child: SignupView(),),
        );

  static const String route = '/signup';
}

class HomeTabConstants {
  static const int defaultTabIndex = drinksTabIndex;
  static const int drinksTabIndex = 0;
  static const int discoveryTabIndex = 1;
  static const int creationTabIndex = 2;
  static const int cellarTabIndex = 3;
  static const int accountTabIndex = 4;

  static const Map<int, String> routesName = {
    drinksTabIndex: DrinksRoute.route,
    discoveryTabIndex: DiscoveryRoute.route,
    creationTabIndex: CreationRoute.route,
    cellarTabIndex: CellarRoute.route,
    accountTabIndex: AccountRoute.route,
  };
}

class HomeRoute extends StatefulShellRoute {
  HomeRoute()
      : super.indexedStack(
          builder: (context, state, navigationShell) {
            return HomeView(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _drinksNavigatorKey,
              observers: [EventGoRouterObserver()],
              routes: [
                DrinksRoute(),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _discoveryNavigatorKey,
              observers: [EventGoRouterObserver()],
              routes: [
                DiscoveryRoute(),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _creationNavigatorKey,
              observers: [EventGoRouterObserver()],
              routes: [
                CreationRoute(),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _cellarNavigatorKey,
              observers: [EventGoRouterObserver()],
              routes: [
                CellarRoute(),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _accountNavigatorKey,
              observers: [EventGoRouterObserver()],
              routes: [
                AccountRoute(),
              ],
            ),
          ],
        );

  static String route(int index) {
    return switch (index) {
      0 => DrinksRoute.route,
      1 => DiscoveryRoute.route,
      2 => CreationRoute.route,
      3 => CellarRoute.route,
      4 => AccountRoute.route,
      _ => DrinksRoute.route,
    };
  }
}

class DrinksRoute extends GoRoute {
  DrinksRoute()
      : super(
          path: route,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: DrinksView(),
            );
          },
          routes: [
            DrinkDetailsRoute(),
          ],
        );

  static const String route = '/drinks';
}

class DiscoveryRoute extends GoRoute {
  DiscoveryRoute()
      : super(
          path: route,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: DiscoveryView(),
            );
          },
        );

  static const String route = '/discovery';
}

class CreationRoute extends GoRoute {
  CreationRoute()
      : super(
          path: route,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: CreationView(),
            );
          },
        );

  static const String route = '/creation';
}

class CellarRoute extends GoRoute {
  CellarRoute()
      : super(
          path: route,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: CellarView(),
            );
          },
        );

  static const String route = '/statistics';
}

class AccountRoute extends GoRoute {
  AccountRoute()
      : super(
          path: route,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: AccountView(),
            );
          },
          routes: [
            ProfileEditRoute(),
          ],
        );

  static const String route = '/account';
}

class ProfileEditRoute extends GoRoute {
  ProfileEditRoute()
      : super(
          path: '$_subRoute',
          builder: (context, state) {
            return const ProfileEditView();
          },
        );

  static const String _subRoute = 'edit';

  static String route() {
    return '${AccountRoute.route}/$_subRoute';
  }
}

class DrinkDetailsRoute extends GoRoute {
  DrinkDetailsRoute()
      : super(
          path: '$_subRoute/:$_drinkIdKey',
          pageBuilder: (context, state) {
            final drinkId = state.pathParameters[_drinkIdKey] ?? '';
            final initialDrink = state.extra! as Drink;
            
            return FadeTransitionPage(
              child: DrinkDetailsView(
                drinkId: drinkId,
                initialDrink: initialDrink,
              ),
            );
          },
        );

  static const String _drinkIdKey = 'drinkId';
  static const String _subRoute = 'details';

  static String route(String drinkId) {
    return '${DrinksRoute.route}/$_subRoute/$drinkId';
  }
}
