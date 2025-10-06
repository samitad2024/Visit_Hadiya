/// Domain model representing a culture topic entry.
class CultureTopic {
  final String id;
  final String titleKey; // localization key
  final String bodyKey; // localization key

  const CultureTopic({
    required this.id,
    required this.titleKey,
    required this.bodyKey,
  });
}
