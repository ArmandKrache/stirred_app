import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/utils/app_data.dart';
import 'package:template_app/views/LoginView.dart';
import 'package:template_app/views/championDetails.dart';
import 'package:template_app/views/home.dart';

enum NavPosition {
  inChampionDetails,
  inHome,
  inLogin
}

const Map<NavPosition, String> navStrings = {
  NavPosition.inChampionDetails: "champion_details",
  NavPosition.inHome: "home",
  NavPosition.inLogin: "login",
};

class AppRouter {
  static FluroRouter router = FluroRouter();
  static List<NavPosition> navHistory = [];

  static void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove("username");
    await prefs.remove("password");
    AppData.setCurrentUser(null);
    AppRouter.push(context, NavPosition.inLogin,
        replace: true, transition: TransitionType.inFromLeft);
  }

  static void pop(BuildContext context) {
    router.pop(context);
  }

  static void push(BuildContext context, NavPosition nextView,
      {bool replace = false,
        TransitionType transition = TransitionType.inFromRight,
        int durationInMilliseconds = 200,
        RouteSettings? routeSettings,
        Map<String, dynamic>? navDetails}) {
    router.navigateTo(context, navStrings[nextView]!,
        replace: replace,
        transition: transition,
        transitionDuration: Duration(milliseconds: durationInMilliseconds),
        routeSettings: routeSettings);
  }

  static void initRouter() {
    router.define(navStrings[NavPosition.inChampionDetails]!,
        handler: _championDetailsHandler);
    router.define(navStrings[NavPosition.inHome]!, handler: _homeHandler);
    router.define(navStrings[NavPosition.inLogin]!, handler: _loginHandler);
  }

  static final Handler _championDetailsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const ChampionsDetailsView();
      });


  static final Handler _homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const HomeView();
      });

  static final Handler _loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
        return const LoginView();
  });
}
