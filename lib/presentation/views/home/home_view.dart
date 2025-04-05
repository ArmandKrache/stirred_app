import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(),
        child: Center(
          child: StirText.titleLarge('Home'),
        ),
      ),
    );
  }
}
