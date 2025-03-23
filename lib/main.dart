import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/login/login_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/signup/signup_cubit.dart';
import 'package:stirred_app/src/presentation/data/global_data_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translations/',
        fallbackLocale: const Locale('en', 'US'),
        child: const StirredApp(),
      ),
    ),
  );
}

class StirredApp extends ConsumerWidget {
  const StirredApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize global data
    ref.watch(globalDataInitializationProvider);

    // Watch providers that need to be initialized early
    ref.watch(loginCubitProvider);
    ref.watch(signupCubitProvider);
    ref.watch(profileCubitProvider);
    ref.watch(homepageCubitProvider);

    return OKToast(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Stirred',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: appRouter.config(),
      ),
    );
  }
}