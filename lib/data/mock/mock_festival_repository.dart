import '../../models/festival_event.dart';

/// Mock repository providing Ethiopian and Hadiya cultural festivals
class MockFestivalRepository {
  List<FestivalEvent> fetchEvents() {
    final now = DateTime.now();
    final currentYear = now.year;

    return [
      // Ethiopian New Year - Meskel
      FestivalEvent(
        id: 'meskel',
        titleKey: 'festival_meskel_title',
        descriptionKey: 'festival_meskel_desc',
        date: DateTime(currentYear, 9, 27),
        category: FestivalCategory.religious,
        location: 'Hossana City Center',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800',
          'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400',
        isFeatured: true,
        activities: ['meskel_bonfire', 'traditional_dance', 'procession'],
        duration: '2 days',
        contactInfo: '+251 46 550 1234',
      ),

      // Hadiya Cultural Day
      FestivalEvent(
        id: 'hadiya_day',
        titleKey: 'festival_hadiya_day_title',
        descriptionKey: 'festival_hadiya_day_desc',
        date: DateTime(currentYear, 11, 15),
        endDate: DateTime(currentYear, 11, 17),
        category: FestivalCategory.cultural,
        location: 'Hossana Stadium',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800',
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400',
        isFeatured: true,
        activities: [
          'traditional_dance',
          'food_exhibition',
          'cultural_parade',
          'craft_market',
        ],
        duration: '3 days',
        contactInfo: '+251 46 550 2345',
        websiteUrl: 'https://hadiyaculture.gov.et',
      ),

      // Ethiopian Christmas - Ganna
      FestivalEvent(
        id: 'ganna',
        titleKey: 'festival_ganna_title',
        descriptionKey: 'festival_ganna_desc',
        date: DateTime(currentYear + 1, 1, 7),
        category: FestivalCategory.religious,
        location: 'Various Churches in Hossana',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=400',
        isFeatured: true,
        activities: ['church_service', 'traditional_games', 'feast'],
        duration: '1 day',
      ),

      // Timkat (Epiphany)
      FestivalEvent(
        id: 'timkat',
        titleKey: 'festival_timkat_title',
        descriptionKey: 'festival_timkat_desc',
        date: DateTime(currentYear + 1, 1, 19),
        endDate: DateTime(currentYear + 1, 1, 20),
        category: FestivalCategory.religious,
        location: 'Hossana River Area',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1569163139394-de4798aa62b6?w=800',
          'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1569163139394-de4798aa62b6?w=400',
        isFeatured: true,
        activities: ['baptism_ceremony', 'procession', 'traditional_music'],
        duration: '2 days',
      ),

      // Coffee Ceremony Festival
      FestivalEvent(
        id: 'coffee_festival',
        titleKey: 'festival_coffee_title',
        descriptionKey: 'festival_coffee_desc',
        date: DateTime(currentYear, 12, 5),
        category: FestivalCategory.food,
        location: 'Hossana Coffee Cultural Center',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800',
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
        isFeatured: false,
        activities: [
          'coffee_ceremony',
          'barista_competition',
          'coffee_tasting',
        ],
        duration: '1 day',
        entryFee: 50.0,
        contactInfo: '+251 46 550 3456',
      ),

      // Harvest Festival
      FestivalEvent(
        id: 'harvest_festival',
        titleKey: 'festival_harvest_title',
        descriptionKey: 'festival_harvest_desc',
        date: DateTime(currentYear, 10, 10),
        endDate: DateTime(currentYear, 10, 12),
        category: FestivalCategory.harvest,
        location: 'Rural Hadiya Districts',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800',
          'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=400',
        isFeatured: false,
        activities: [
          'harvest_celebration',
          'traditional_food',
          'farming_exhibition',
        ],
        duration: '3 days',
      ),

      // Traditional Music Festival
      FestivalEvent(
        id: 'music_festival',
        titleKey: 'festival_music_title',
        descriptionKey: 'festival_music_desc',
        date: DateTime(currentYear, 11, 25),
        category: FestivalCategory.music,
        location: 'Hossana Cultural Hall',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?w=800',
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1511735111819-9a3f7709049c?w=400',
        isFeatured: true,
        activities: [
          'live_performance',
          'traditional_instruments',
          'dance_competition',
        ],
        duration: '1 day',
        entryFee: 100.0,
        contactInfo: '+251 46 550 4567',
        websiteUrl: 'https://hadiyamusic.et',
      ),

      // Buhe (New Year for Youth)
      FestivalEvent(
        id: 'buhe',
        titleKey: 'festival_buhe_title',
        descriptionKey: 'festival_buhe_desc',
        date: DateTime(currentYear, 8, 19),
        category: FestivalCategory.traditional,
        location: 'Throughout Hossana',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=400',
        isFeatured: false,
        activities: ['door_to_door_singing', 'traditional_games', 'bonfire'],
        duration: '1 day',
      ),

      // Hadiya Sports Day
      FestivalEvent(
        id: 'sports_day',
        titleKey: 'festival_sports_title',
        descriptionKey: 'festival_sports_desc',
        date: DateTime(currentYear, 10, 30),
        category: FestivalCategory.sport,
        location: 'Hossana Stadium',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=400',
        isFeatured: false,
        activities: ['football_tournament', 'athletics', 'traditional_sports'],
        duration: '1 day',
        contactInfo: '+251 46 550 5678',
      ),

      // Art & Craft Exhibition
      FestivalEvent(
        id: 'art_exhibition',
        titleKey: 'festival_art_title',
        descriptionKey: 'festival_art_desc',
        date: DateTime(currentYear, 12, 15),
        endDate: DateTime(currentYear, 12, 20),
        category: FestivalCategory.art,
        location: 'Hossana Art Gallery',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=800',
          'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=400',
        isFeatured: false,
        activities: ['art_exhibition', 'craft_workshop', 'live_painting'],
        duration: '6 days',
        entryFee: 30.0,
        contactInfo: '+251 46 550 6789',
      ),

      // Community Unity Day
      FestivalEvent(
        id: 'unity_day',
        titleKey: 'festival_unity_title',
        descriptionKey: 'festival_unity_desc',
        date: DateTime(currentYear + 1, 2, 14),
        category: FestivalCategory.community,
        location: 'Hossana Public Park',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=400',
        isFeatured: false,
        activities: ['community_gathering', 'peace_dialogue', 'shared_meal'],
        duration: '1 day',
      ),

      // Historical Commemoration Day
      FestivalEvent(
        id: 'historical_day',
        titleKey: 'festival_historical_title',
        descriptionKey: 'festival_historical_desc',
        date: DateTime(currentYear, 9, 12),
        category: FestivalCategory.historical,
        location: 'Hadiya Heritage Museum',
        latitude: 7.5497,
        longitude: 37.8537,
        imageUrls: [
          'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=800',
        ],
        thumbnailUrl:
            'https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=400',
        isFeatured: false,
        activities: [
          'museum_tour',
          'history_lectures',
          'documentary_screening',
        ],
        duration: '1 day',
        entryFee: 20.0,
        contactInfo: '+251 46 550 7890',
      ),
    ];
  }

  /// Fetch events for a specific month
  List<FestivalEvent> fetchEventsForMonth(DateTime month) {
    final allEvents = fetchEvents();
    return allEvents.where((event) {
      return event.date.year == month.year && event.date.month == month.month;
    }).toList();
  }

  /// Fetch featured events
  List<FestivalEvent> fetchFeaturedEvents() {
    return fetchEvents().where((event) => event.isFeatured).toList();
  }

  /// Fetch events by category
  List<FestivalEvent> fetchEventsByCategory(FestivalCategory category) {
    return fetchEvents().where((event) => event.category == category).toList();
  }
}
