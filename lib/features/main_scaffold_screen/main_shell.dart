import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meals_app/core/styles/app_colors.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        indicatorColor: AppColors.orange.withAlpha(48),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined,color: AppColors.navBarIconColor,),
            selectedIcon: Icon(Icons.home,color: AppColors.orange,),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline ,color: AppColors.navBarIconColor,),
            selectedIcon: Icon(Icons.add_circle ,color: AppColors.orange,),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined ,color: AppColors.navBarIconColor,),
            selectedIcon: Icon(Icons.restaurant_menu ,color: AppColors.orange,),
            label: 'My Meals',
          ),
        ],
      ),
    );
  }
}