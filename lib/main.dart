import 'dart:io';
import 'dart:typed_data';

import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/config/themes/app_themes.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/login/login_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/root_navigation/root_navigation_cubit.dart';
import 'package:stirred_app/src/utils/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  HttpOverrides.global = MyHttpOverrides();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations/',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RootNavigationCubit()),
        BlocProvider(create: (context) => LoginCubit(
          locator<ApiRepository>(),)
        ),
        BlocProvider(create: (context) => HomepageCubit(
          locator<ApiRepository>(),)
        ),
        BlocProvider(create: (context) => DrinkCubit(
          locator<ApiRepository>(),)
        ),
      ],
      child: OKToast(child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
        title: appTitle,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.light,
      )),
    );
  }
}

/// TODO : remove after server release
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}