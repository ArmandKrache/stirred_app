// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';

class CellarView extends ConsumerWidget {
  const CellarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: const SafeArea(
        child: Center(
          child: StirText.titleLarge('Cellar'),
        ),
      ),
    );
  }
}
