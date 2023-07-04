import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'assets/translations/',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashView(),
    );
  }
}
