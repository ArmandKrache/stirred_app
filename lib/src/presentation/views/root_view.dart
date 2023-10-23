import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/presentation/cubits/root_navigation/nav_bar_items.dart';
import 'package:stirred_app/src/presentation/cubits/root_navigation/root_navigation_cubit.dart';
import 'package:stirred_app/src/presentation/data/global_data_functions.dart';
import 'package:stirred_app/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class RootView extends HookWidget {
  const RootView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    final rootNavigationCubit = BlocProvider.of<RootNavigationCubit>(context);

    useEffect(() {
      initialChoicesDataRetrieve();
      return;
    }, const []);

    return Scaffold(
      bottomNavigationBar: BlocBuilder<RootNavigationCubit, RootNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: true,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  state.index == 0 ? Icons.home_rounded : Icons.home_outlined,
                  color: Colors.black,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state.index == 1 ? Icons.lightbulb : Icons.lightbulb_outlined,
                  color: Colors.black,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state.index == 2 ? Icons.add_box_rounded : Icons.add_box_outlined,
                  color: Colors.black,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state.index == 3 ? Icons.checklist_rounded : Icons.checklist_outlined ,
                  color: Colors.black,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  state.index == 4 ? Icons.person_rounded : Icons.person_outlined ,
                  color: Colors.black,
                ),
                label: '',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.drinks);
              } else if (index == 1) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.profiles);
              } else if (index == 2) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.recipes);
              }
              else if (index == 3) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.glasses);
              }
              else if (index == 4) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.ingredients);
              }
            },
          );
        },
      ),
      body: BlocBuilder<RootNavigationCubit, RootNavigationState>(
          builder: (_, state) {
            if (state.navbarItem == NavbarItem.drinks) {
              return const Center(child: Text("Drinks"));
              /// return const DrinksView();
            } else if (state.navbarItem == NavbarItem.profiles) {
              return const Center(child: Text("Surprise Me"));
              /// return const ProfilesView();
            } else if (state.navbarItem == NavbarItem.recipes) {
              return const Center(child: Text("Create a recipe"));
              /// return const RecipesView();
            } else if (state.navbarItem == NavbarItem.glasses) {
              return const Center(child: Text("Cellar"));
              /// return const GlassesView();
            } else if (state.navbarItem == NavbarItem.ingredients) {
              return const Center(child: Text("Profile"));
              /// return const IngredientsView();
            }
            return const SizedBox();
          }
      ),
    );
  }
}

