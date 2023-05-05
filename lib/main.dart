import 'package:flutter/material.dart';
import 'package:template_app/SplashView.dart';
import 'package:template_app/router.dart';
import 'package:template_app/utils/app_colors.dart';
import 'package:template_app/utils/app_config.dart';
import 'package:template_app/views/dashboard.dart';
import 'package:template_app/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppRouter.initRouter();
  await AppConfig.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'template_app',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
