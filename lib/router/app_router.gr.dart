// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DrinkView]
class DrinkRoute extends PageRouteInfo<DrinkRouteArgs> {
  DrinkRoute({Key? key, required String id, List<PageRouteInfo>? children})
    : super(
        DrinkRoute.name,
        args: DrinkRouteArgs(key: key, id: id),
        initialChildren: children,
      );

  static const String name = 'DrinkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DrinkRouteArgs>();
      return DrinkView(key: args.key, id: args.id);
    },
  );
}

class DrinkRouteArgs {
  const DrinkRouteArgs({this.key, required this.id});

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'DrinkRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [HomepageView]
class HomepageRoute extends PageRouteInfo<void> {
  const HomepageRoute({List<PageRouteInfo>? children})
    : super(HomepageRoute.name, initialChildren: children);

  static const String name = 'HomepageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomepageView();
    },
  );
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return LoginView(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfileEditView]
class ProfileEditRoute extends PageRouteInfo<void> {
  const ProfileEditRoute({List<PageRouteInfo>? children})
    : super(ProfileEditRoute.name, initialChildren: children);

  static const String name = 'ProfileEditRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileEditView();
    },
  );
}

/// generated route for
/// [ProfileView]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileView();
    },
  );
}

/// generated route for
/// [RootView]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootView();
    },
  );
}

/// generated route for
/// [SignupView]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignupView();
    },
  );
}
