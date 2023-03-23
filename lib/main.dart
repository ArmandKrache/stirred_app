import 'package:flutter/material.dart';
import 'package:ttfa/router.dart';
import 'package:ttfa/utils/app_colors.dart';
import 'package:ttfa/views/dashboard.dart';
import 'package:ttfa/views/home.dart';

void main() {
  AppRouter.initRouter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTFA',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
