import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stirred_app/core/events/event_manager.dart';
import 'package:stirred_app/core/extensions/widget_ref.dart';
import 'package:stirred_app/core/theme/text.dart';
import 'package:stirred_app/presentation/router.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_icon_notification_badge.dart';

/// The home page of the application.
class HomeView extends ConsumerWidget {
  const HomeView({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('HomePage'));

  /// The navigation shell to display.
  final StatefulNavigationShell navigationShell;

  void _onItemTapped(int index, WidgetRef ref) {
    final scrollToTop = index == HomeTabConstants.drinksTabIndex && router.currentRoute == DrinksRoute.route;
    final initialLocation = !scrollToTop && index == navigationShell.currentIndex;

    navigationShell.goBranch(
      index,
      initialLocation: initialLocation,
    );

    // if (scrollToTop) {
    //   ref.read(pageControllerNotifierProvider.notifier).scrollToTop();
    // }

    EventManager.addEnterNavigationEvent(newLocation: HomeTabConstants.routesName[index] ?? 'other');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationItems = buildNavigationItems(context, ref);
    return PortraitBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        body: navigationShell,
        onItemTapped: _onItemTapped,
        navigationItems: navigationItems,
      );
  }

  List<BottomNavigationBarItem> buildNavigationItems(BuildContext context, WidgetRef ref) {
    return [
      const BottomNavigationBarItem(
        icon: StirIconNotificationBadge(
          iconData: Icons.grade_outlined,
        ),
        activeIcon: StirIconNotificationBadge(
          iconData: Icons.grade,
        ),
        label: 'Drinks',
      ),
      const BottomNavigationBarItem(
        icon: StirIconNotificationBadge(
          iconData: Icons.gamepad_outlined,
        ),
        activeIcon: StirIconNotificationBadge(
          iconData: Icons.gamepad,
        ),
        label: 'Discovery',
      ),
      const BottomNavigationBarItem(
        icon: StirIconNotificationBadge(
          iconData: Icons.add_outlined,
        ),
        activeIcon: StirIconNotificationBadge(
          iconData: Icons.add,
        ),
        label: 'Create',
      ),
      const BottomNavigationBarItem(
        icon: StirIconNotificationBadge(
          iconData: Icons.wine_bar_outlined,
        ),
        activeIcon: StirIconNotificationBadge(
          iconData: Icons.wine_bar,
        ),
        label: 'Cellar',
      ),
      const BottomNavigationBarItem(
        icon: StirIconNotificationBadge(
          iconData: Icons.person_outline,
        ),
        activeIcon: StirIconNotificationBadge(
          iconData: Icons.person,
        ),
        label: 'Account',
      ),
    ];
  }
}

/// The bottom navigation bar for portrait mode.
class PortraitBottomNavigationBar extends ConsumerWidget {
  const PortraitBottomNavigationBar({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.navigationItems,
    required this.onItemTapped,
  });

  /// The current index of the navigation.
  final int currentIndex;

  /// The body to display.
  final Widget body;

  /// The navigation items to display.
  final List<BottomNavigationBarItem> navigationItems;

  /// The callback to call when a tab is tapped.
  final Function(int, WidgetRef) onItemTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shadows = ref.shadows;
    final colors = ref.colors;

    return Scaffold(
      body: body,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: shadows.noShadow,
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colors.surface,
          selectedItemColor: colors.secondary,
          unselectedItemColor: colors.onSurface,
          selectedLabelStyle: StirTextTheme.labelSmall,
          unselectedLabelStyle: StirTextTheme.labelSmall,
          onTap: (index) async => onItemTapped(index, ref),
          items: navigationItems,
        ),
      ),
    );
  }
}
