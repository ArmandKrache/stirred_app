import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stirred_app/src/core/widgets/drink_card.dart';
import 'package:stirred_app/src/core/widgets/search_bar.dart';
import 'package:stirred_app/src/presentation/cubits/homepage/homepage_cubit.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_cubit.dart';
import 'package:stirred_app/src/presentation/views/homepage_loading.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

@RoutePage()
class HomepageView extends HookConsumerWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homepageCubit = ref.watch(homepageCubitProvider);
    final profileCubit = ref.watch(profileCubitProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBarWidget(
                onChanged: (value) {
                  homepageCubit.fetchDrinksList(query: value);
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HomepageCubit, HomepageState>(
                bloc: homepageCubit,
                builder: (context, homepageState) {
                  return BlocBuilder<ProfileCubit, ProfileState>(
                    bloc: profileCubit,
                    builder: (context, profileState) {
                      if (homepageState is HomepageLoading) {
                        return const HomepageLoadingView();
                      }
                      if (homepageState is HomepageError) {
                        return Center(
                          child: Text(homepageState.exception.toString()),
                        );
                      }
                      return _buildDataWidgets(
                        context: context,
                        drinks: homepageState.drinks,
                        profileState: profileState,
                        homepageCubit: homepageCubit,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataWidgets({
    required BuildContext context,
    required List<Drink> drinks,
    required ProfileState profileState,
    required HomepageCubit homepageCubit,
  }) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        final drink = drinks[index];
        return DrinkCard(
          drink: drink,
          isFavorite: profileState is ProfileLoaded
              ? profileState.profile.preferences.favorites.any((fav) => fav.id == drink.id)
              : false,
          onFavoriteTap: () {
            if (profileState is! ProfileLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You need to be logged in to add favorites'),
                ),
              );
              return;
            }
            homepageCubit.toggleFavorite(drinkId: drink.id);
          },
        );
      },
    );
  }
}