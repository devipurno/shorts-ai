import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routing/routes.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentPath,
    required this.onDestinationSelected,
  });

  final String currentPath;
  final ValueChanged<String> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex(currentPath),
      backgroundColor: AppColors.surface1,
      indicatorColor: AppColors.goldGlow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.video_library_outlined),
          selectedIcon: Icon(Icons.video_library),
          label: 'Library',
        ),
        NavigationDestination(
          icon: Icon(Icons.add_circle_outline),
          selectedIcon: Icon(Icons.add_circle),
          label: 'Create',
        ),
        NavigationDestination(
          icon: Icon(Icons.analytics_outlined),
          selectedIcon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onDestinationSelected: (index) =>
          onDestinationSelected(AppRoutes.mainTabs[index]),
    );
  }

  int _selectedIndex(String location) {
    final index = AppRoutes.mainTabs.indexOf(location);
    return index == -1 ? 0 : index;
  }
}
