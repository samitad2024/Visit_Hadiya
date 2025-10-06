import '../../models/culture_topic.dart';

class MockCultureRepository {
  List<CultureTopic> fetchTopics() {
    return const [
      CultureTopic(
        id: 'language',
        titleKey: 'culture_language_title',
        bodyKey: 'culture_language_body',
      ),
      CultureTopic(
        id: 'music_dance',
        titleKey: 'culture_music_title',
        bodyKey: 'culture_music_body',
      ),
      CultureTopic(
        id: 'festivals',
        titleKey: 'culture_festivals_title',
        bodyKey: 'culture_festivals_body',
      ),
      CultureTopic(
        id: 'customs',
        titleKey: 'culture_customs_title',
        bodyKey: 'culture_customs_body',
      ),
      CultureTopic(
        id: 'social_structure',
        titleKey: 'culture_social_title',
        bodyKey: 'culture_social_body',
      ),
    ];
  }
}
