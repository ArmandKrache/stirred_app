import 'package:flutter/material.dart';
import 'dart:async';

class RootView extends StatelessWidget {
  const RootView({super.key});


  void _dispatch() async {
    // TODO: Implement dispatch
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      _dispatch();
    });
    return const CustomSplashScreen();
  }
}

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF2654a8), Color(0xFF539ce0)],
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash-icon.png")
          ],
        ),
      ),
    );
  }
}
