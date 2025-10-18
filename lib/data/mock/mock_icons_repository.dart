import '../../models/person_icon.dart';

class MockIconsRepository {
  List<PersonIcon> fetchIcons() {
    return const [
      // Leaders
      PersonIcon(
        id: 'nigist_eleni',
        nameKey: 'icon_nigist_eleni',
        subtitleKey: '15th-century queen, a symbol of Hadiya sovereignty',
        imageAsset: 'assets/images/nigist_eleni.jpeg',
        category: IconCategory.leader,
      ),
      PersonIcon(
        id: 'professor_beyene',
        nameKey: 'icon_professor_beyene',
        subtitleKey:
            'Academic and political leader advocating for Hadiya rights',
        imageAsset: 'assets/images/professor_beyene.png',
        category: IconCategory.leader,
      ),

      // Warriors
      PersonIcon(
        id: 'Colonel_Bezabih_Petros',
        nameKey: 'Colonel Bezabih Petros',
        subtitleKey: 'icon_warrior_19c',
        imageAsset: 'assets/images/colonel_bezabih_petros.png',
        category: IconCategory.warrior,
      ),
      PersonIcon(
        id: 'fitawrari_geja_geribo',
        nameKey: 'Fitawrari Geja Geribo',
        subtitleKey: 'Respected military leader in the 20th century',
        imageAsset: 'images/Fitawurari_Geja_Geribo.png',
        category: IconCategory.warrior,
      ),
      // Cultural Icons
      PersonIcon(
        id: 'cultural_1',
        nameKey: 'Beautiful Hadiyya Women',
        subtitleKey: 'Represents the beauty and resilience of Hadiya women',
        imageAsset: 'assets/images/hadiya_women.png',
        category: IconCategory.cultural,
      ),
      PersonIcon(
        id: 'cultural_2',
        nameKey: 'Beautiful Hadiyya Women',
        subtitleKey: 'Showcasing traditional attire across generations',
        imageAsset: 'assets/images/old_hadiya_women.png',
        category: IconCategory.cultural,
      ),
      PersonIcon(
        id: 'cultural_3',
        nameKey: 'Hadiyya Cultural Dressing',
        subtitleKey: 'Full spectrum of Hadiya traditional clothing',
        imageAsset: 'assets/images/artists.png',
        category: IconCategory.cultural,
      ),
      PersonIcon(
        id: 'cultural_4',
        nameKey: 'music artist',
        subtitleKey: 'Keeper of Hadiya\'s rich musical tradition',
        imageAsset: 'assets/images/artist_collection.png',
        category: IconCategory.cultural,
      ),
    ];
  }
}
