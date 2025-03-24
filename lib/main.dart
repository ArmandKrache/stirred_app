import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stirred_app/router/app_router.dart';
import 'package:stirred_app/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:stirred_app/presentation/cubits/login/login_cubit.dart';
import 'package:stirred_app/presentation/cubits/profile/profile_cubit.dart';
import 'package:stirred_app/presentation/cubits/signup/signup_cubit.dart';
import 'package:stirred_app/presentation/data/global_data_functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: const StirredApp(),
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
        locale: Locale('en'),
        routerConfig: appRouter.config(),
      ),
    );
  }
}