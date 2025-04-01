import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text_field.dart';

class DrinksView extends ConsumerWidget {
  const DrinksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.filter_list, size: 32,),
                const SizedBox(width: 8),
                StirText.titleLarge('Trending'),
                const SizedBox(width: 24),
                Expanded(
                  child: const StirTextField(hint: 'Search'),
                ),
              ],
            ),
            Center(child: const Text('Drinks')),
          ],
        ),
      ),
    );
  }
}
