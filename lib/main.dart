import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:stirred_app/presentation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: StirredApp(),
    ),
  );
}

class StirredApp extends ConsumerWidget {
  const StirredApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OKToast(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Stirred',
        locale: const Locale('en'),
        routerConfig: router,
      ),
    );
  }
}