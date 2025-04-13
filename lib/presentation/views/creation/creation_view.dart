import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/core/constants/spacing.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';

class CreationView extends ConsumerWidget {
  const CreationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(StirSpacings.medium24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: StirSpacings.medium24),
                const StirText.headlineMedium(
                  'Create Feature',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: StirSpacings.small8),
                const StirText.bodyLarge(
                  'Create your own drinks and share them with the community.\nComing soon!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
