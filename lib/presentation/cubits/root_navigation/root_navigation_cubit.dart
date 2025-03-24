import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/router/app_router.dart';
import 'package:stirred_app/presentation/cubits/base/base_cubit.dart';
import 'package:stirred_app/presentation/cubits/root_navigation/nav_bar_items.dart';
import 'package:equatable/equatable.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'root_navigation_state.dart';

final rootNavigationCubitProvider = Provider.autoDispose<RootNavigationCubit>((ref) {
  final tokenManager = ref.watch(tokenManagerProvider.notifier);
  return RootNavigationCubit(tokenManager);
});

class RootNavigationCubit extends BaseCubit<RootNavigationState, Map<String, dynamic>> {
  final TokenManager _tokenManager;

  RootNavigationCubit(this._tokenManager) : super(const RootNavigationSuccess(navbarItem: NavbarItem.drinks, index: 0), {});

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.drinks:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.drinks, index: 0));
        break;
      case NavbarItem.profiles:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.profiles, index: 1));
        break;
      case NavbarItem.recipes:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.recipes, index: 2));
        break;
      case NavbarItem.glasses:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.glasses, index: 3));
        break;
      case NavbarItem.ingredients:
        emit(const RootNavigationSuccess(navbarItem: NavbarItem.ingredients, index: 4));
        break;
    }
  }

  Future<void> logOut() async {
    if (isBusy) return;

    await run(() async {
      await _tokenManager.clearTokens();
      appRouter.popUntil((route) => route.data?.name == "LoginRoute");
    });
  }
}