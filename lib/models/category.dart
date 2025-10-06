import 'package:flutter/material.dart';

/// Domain model representing a feature/category on the Home screen.
class Category {
  final String id;
  final String titleKey; // localization key
  final String subtitleKey; // localization key
  final IconData icon;
  final String route; // destination route or placeholder

  const Category({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.route,
  });
}
