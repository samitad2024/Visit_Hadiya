import 'package:flutter/material.dart';
import '../../models/category.dart';

/// Mock repository producing static categories for the Home screen.
class MockCategoryRepository {
  List<Category> fetchCategories() {
    return const [
      Category(
        id: 'history',
        titleKey: 'home_history_title',
        subtitleKey: 'home_history_sub',
        icon: Icons.history,
        route: '/history',
      ),
      Category(
        id: 'culture',
        titleKey: 'home_culture_title',
        subtitleKey: 'home_culture_sub',
        icon: Icons.groups_3,
        route: '/culture',
      ),
      Category(
        id: 'sites',
        titleKey: 'home_sites_title',
        subtitleKey: 'home_sites_sub',
        icon: Icons.place_outlined,
        route: '/sites',
      ),
      Category(
        id: 'persons',
        titleKey: 'home_persons_title',
        subtitleKey: 'home_persons_sub',
        icon: Icons.star_border_rounded,
        route: '/persons',
      ),
      Category(
        id: 'festivals',
        titleKey: 'home_festivals_title',
        subtitleKey: 'home_festivals_sub',
        icon: Icons.event_available_outlined,
        route: '/festivals',
      ),
      Category(
        id: 'audio',
        titleKey: 'home_audio_title',
        subtitleKey: 'home_audio_sub',
        icon: Icons.headphones_outlined,
        route: '/media',
      ),
    ];
  }
}
