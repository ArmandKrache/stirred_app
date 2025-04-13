import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/core/constants/spacing.dart';
import 'package:stirred_app/presentation/providers/current_data.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_icon.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';
import 'package:stirred_app/presentation/router.dart';

class AccountView extends ConsumerWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentDataNotifierProvider).value?.when(
          authentified: (user) => user,
          unauthentified: (_) => null,
        );

    if (user == null) {
      return const Scaffold(
        body: Center(child: StirText.titleLarge('No user found')),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(StirSpacings.small16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user.picture != null 
                      ? NetworkImage(user.picture!) 
                      : null,
                    child: user.picture == null 
                      ? const StirIcon.medium(iconData: Icons.person)
                      : null,
                  ),
                  const SizedBox(width: StirSpacings.small16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StirText.titleLarge(user.name ?? ''),
                        StirText.bodyMedium(user.email ?? ''),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => router.go(ProfileEditRoute.route()),
                  ),
                ],
              ),
            ),

            // Preferences Section
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(StirSpacings.small16),
                children: [
                  _buildSection(
                    context: context,
                    title: 'Drink Preferences',
                    items: user.preferences?.favorites.map((e) => e.name).toList() ?? [],
                  ),
                  _buildSection(
                    context: context,
                    title: 'Likes',
                    items: user.preferences?.likes.map((e) => e.name).toList() ?? [],
                  ),
                  _buildSection(
                    context: context,
                    title: 'Allergies',
                    items: user.preferences?.allergies.map((e) => e.name).toList() ?? [],
                  ),
                  _buildSection(
                    context: context,
                    title: 'Dislikes',
                    items: user.preferences?.dislikes.map((e) => e.name).toList() ?? [],
                  ),
                ],
              ),
            ),
            const SizedBox(height: StirSpacings.small16),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: StirSpacings.small8),
          child: StirText.titleMedium(title),
        ),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.only(bottom: StirSpacings.medium24),
            child: StirText.bodyMedium('No items added yet'),
          )
        else
          Wrap(
            spacing: StirSpacings.small8,
            runSpacing: StirSpacings.small8,
            children: items.map((item) => _buildChip(context, item)).toList(),
          ),
        const SizedBox(height: StirSpacings.medium24),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: StirSpacings.small8, vertical: StirSpacings.small4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(StirSpacings.small16),
      ),
      child: StirText.bodyMedium(label),
    );
  }
}
