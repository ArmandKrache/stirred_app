import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';

class CreationView extends ConsumerWidget {
  const CreationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(),
        child: Center(
          child: StirText.titleLarge('Creation'),
        ),
      ),
    );
  }
}
