import '../../models/person_icon.dart';

class MockIconsRepository {
  List<PersonIcon> fetchIcons() {
    return const [
      // Leaders
      PersonIcon(
        id: 'garad_aze',
        nameKey: 'icon_garad_aze',
        subtitleKey: 'icon_leader_18c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.leader,
      ),
      PersonIcon(
        id: 'garad_sidi_mohammed',
        nameKey: 'icon_garad_sidi_mohammed',
        subtitleKey: 'icon_leader_19c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.leader,
      ),
      // Warriors
      PersonIcon(
        id: 'warrior_1',
        nameKey: 'icon_warrior_1',
        subtitleKey: 'icon_warrior_19c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.warrior,
      ),
      PersonIcon(
        id: 'warrior_2',
        nameKey: 'icon_warrior_2',
        subtitleKey: 'icon_warrior_20c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.warrior,
      ),
      // Cultural Icons
      PersonIcon(
        id: 'cultural_1',
        nameKey: 'icon_cultural_1',
        subtitleKey: 'icon_cultural_20c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.cultural,
      ),
      PersonIcon(
        id: 'cultural_2',
        nameKey: 'icon_cultural_2',
        subtitleKey: 'icon_cultural_21c',
        imageAsset: 'assets/images/portrait_placeholder.svg',
        category: IconCategory.cultural,
      ),
    ];
  }
}
