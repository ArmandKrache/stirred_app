import 'package:bloc/bloc.dart';
import 'package:cocktail_app/src/presentation/cubits/base/base_cubit.dart';
import 'package:cocktail_app/src/presentation/cubits/root_navigation/nav_bar_items.dart';
import 'package:equatable/equatable.dart';

part 'root_navigation_state.dart';

class RootNavigationCubit extends Cubit<RootNavigationState> {
  RootNavigationCubit() : super(const RootNavigationSuccess(navbarItem: NavbarItem.home, index: 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.home, index: 0));
        break;
      case NavbarItem.settings:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.settings, index: 1));
        break;
      case NavbarItem.profile:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.profile, index: 2));
        break;
    }
  }
}