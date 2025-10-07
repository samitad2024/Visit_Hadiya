enum IconCategory { leader, warrior, cultural }

class PersonIcon {
  final String id;
  final String nameKey; // localization key
  final String subtitleKey; // localization key
  final String imageAsset;
  final IconCategory category;

  const PersonIcon({
    required this.id,
    required this.nameKey,
    required this.subtitleKey,
    required this.imageAsset,
    required this.category,
  });
}
