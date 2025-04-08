// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/core/constants/spacing.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';

class DiscoveryView extends ConsumerWidget {
  const DiscoveryView({super.key});

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
                  Icons.explore_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: StirSpacings.medium24),
                const StirText.headlineMedium(
                  'Discovery Feature',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: StirSpacings.small8),
                const StirText.bodyLarge(
                  'Explore new drinks and find inspiration for your next creation.\nComing soon!',
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
