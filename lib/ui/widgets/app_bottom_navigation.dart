import 'package:flutter/material.dart';

/// Centralized bottom navigation used across screens to ensure
/// consistent behavior and routing.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTap;

  void _defaultNavigate(BuildContext context, int index) {
    // Map indices to named routes used in the app.
    // 0: Home, 1: Explore/Chat, 2: Favorites, 3: Settings
    final route = switch (index) {
      0 => '/home',
      1 => '/chat',
      2 => '/favorites',
      3 => '/settings',
      _ => '/home',
    };

    // Use pushReplacementNamed to avoid stacking multiple copies of the same screen.
    try {
      Navigator.of(context).pushReplacementNamed(route);
    } catch (_) {
      // Fallback to pushNamed if replacement fails for any reason.
      Navigator.of(context).pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (i) {
        if (onTap != null) {
          onTap!(i);
          return;
        }

        _defaultNavigate(context, i);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          selectedIcon: Icon(Icons.chat_bubble),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_border_rounded),
          selectedIcon: Icon(Icons.bookmark_rounded),
          label: 'Saved',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
