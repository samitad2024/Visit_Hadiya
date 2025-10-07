class FestivalEvent {
  final String id;
  final String titleKey; // localization key
  final DateTime date; // Gregorian date for now

  const FestivalEvent({required this.id, required this.titleKey, required this.date});
}
