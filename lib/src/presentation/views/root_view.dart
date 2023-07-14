import 'package:auto_route/auto_route.dart';
import 'package:cocktail_app/src/config/router/app_router.dart';
import 'package:cocktail_app/src/presentation/cubits/root_navigation/nav_bar_items.dart';
import 'package:cocktail_app/src/presentation/cubits/root_navigation/root_navigation_cubit.dart';
import 'package:cocktail_app/src/presentation/views/homepage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class RootView extends HookWidget {
  const RootView({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bottom Navbar Tutorial w/ Bloc'),
      ),
      bottomNavigationBar: BlocBuilder<RootNavigationCubit, RootNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.index,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.settings);
              } else if (index == 2) {
                BlocProvider.of<RootNavigationCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              }
            },
          );
        },
      ),
      body: BlocBuilder<RootNavigationCubit, RootNavigationState>(
          builder: (_, state) {
            if (state.navbarItem == NavbarItem.home) {
              return const HomepageView();
            } else if (state.navbarItem == NavbarItem.settings) {
              // return SettingsScreen();
            } else if (state.navbarItem == NavbarItem.profile) {
              // return ProfileScreen();
            }
            return const SizedBox();
          }),
    );
  }
}