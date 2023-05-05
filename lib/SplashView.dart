import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/router.dart';
import 'package:template_app/utils/app_assets.dart';
import 'dart:async';
import 'package:template_app/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashView createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  void _asyncInit() async {
    Timer(const Duration(seconds: 1), () {
      _dispatch();
    });
  }

  void _dispatch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (false || prefs.containsKey("username") && prefs.containsKey("password")) {
      AppRouter.push(context, NavPosition.inHome, replace: true);
    } else {
      AppRouter.push(context, NavPosition.inLogin, replace: true, transition: TransitionType.fadeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const CustomSplashScreen();
  }
}

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.splashGradient),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.splashIcon)
          ],
        ),
      ),
    );
  }
}
