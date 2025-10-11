/// Represents a festival or cultural event in the Hadiya region
class FestivalEvent {
  final String id;
  final String titleKey; // localization key
  final String descriptionKey; // localization key for description
  final DateTime date; // Gregorian date
  final DateTime? endDate; // For multi-day festivals
  final FestivalCategory category;
  final String? location; // e.g., "Hossana City Center"
  final double? latitude;
  final double? longitude;
  final List<String> imageUrls; // Festival images
  final String? thumbnailUrl; // Main thumbnail
  final bool isFeatured; // Show on home screen
  final List<String> activities; // List of activities (localization keys)
  final String? contactInfo; // Phone or email for inquiries
  final String? websiteUrl;
  final double? entryFee; // Optional entry cost
  final String? duration; // e.g., "3 days", "1 week"

  const FestivalEvent({
    required this.id,
    required this.titleKey,
    required this.descriptionKey,
    required this.date,
    this.endDate,
    required this.category,
    this.location,
    this.latitude,
    this.longitude,
    this.imageUrls = const [],
    this.thumbnailUrl,
    this.isFeatured = false,
    this.activities = const [],
    this.contactInfo,
    this.websiteUrl,
    this.entryFee,
    this.duration,
  });

  /// Check if this is a multi-day event
  bool get isMultiDay => endDate != null && endDate!.isAfter(date);

  /// Check if the event is currently happening
  bool get isHappening {
    final now = DateTime.now();
    final effectiveEndDate = endDate ?? date;
    return now.isAfter(date) &&
        now.isBefore(effectiveEndDate.add(const Duration(days: 1)));
  }

  /// Check if the event is upcoming (in the future)
  bool get isUpcoming => DateTime.now().isBefore(date);

  /// Check if the event is past
  bool get isPast {
    final effectiveEndDate = endDate ?? date;
    return DateTime.now().isAfter(
      effectiveEndDate.add(const Duration(days: 1)),
    );
  }

  /// Get days until the event (negative if past)
  int get daysUntil => date.difference(DateTime.now()).inDays;
}

/// Categories for festivals and cultural events
enum FestivalCategory {
  religious, // Religious celebrations
  cultural, // Cultural festivals
  harvest, // Harvest and agricultural festivals
  music, // Music and dance events
  traditional, // Traditional ceremonies
  food, // Food festivals
  sport, // Sports events
  historical, // Historical commemorations
  art, // Art exhibitions and events
  community, // Community gatherings
}
