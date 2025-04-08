import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/core/constants/spacing.dart';
import 'package:stirred_app/presentation/views/drinks/drinks_notifier.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text_field.dart';
import 'package:stirred_app/presentation/widgets/error_placeholder.dart';
import 'package:stirred_app/presentation/widgets/loading_placeholder.dart';

class DrinksView extends ConsumerWidget {
  const DrinksView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(drinksNotifierProvider);

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: StirSpacings.small16),
        child: notifier.when(
          data: (data) {
            return const Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.filter_list, size: 32,),
                    SizedBox(width: 8),
                    StirText.titleLarge('Trending'),
                    SizedBox(width: 24),
                    Expanded(
                      child: StirTextField(hint: 'Search'),
                    ),
                  ],
                ),
                Center(child: Text('Drinks')),
              ],
            );
          },
          error: (error, stacktrace) => ErrorPlaceholder(
            message: error.toString(),
            stackTrace: stacktrace,
          ),
          loading: () {
            return const LoadingPlaceholder();
          },
        ),
      ),
    );
  }
}
