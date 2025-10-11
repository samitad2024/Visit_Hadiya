import 'package:flutter/foundation.dart';

import '../../models/media_item.dart';

@immutable
class MockMediaRepository {
  const MockMediaRepository();

  List<MediaCategory> fetchCategories() => const [
    MediaCategory(
      id: 'audio_hadiya_songs',
      titleKey: 'media_audio_hadiya_songs',
      type: MediaType.audio,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'audio_folk_songs',
      titleKey: 'media_audio_folk_songs',
      type: MediaType.audio,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'audio_cultural_music',
      titleKey: 'media_audio_cultural_music',
      type: MediaType.audio,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'oral_elders_tales',
      titleKey: 'media_audio_elders_tales',
      type: MediaType.audio,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'oral_leaders_stories',
      titleKey: 'media_audio_leaders_stories',
      type: MediaType.audio,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    // Video categories
    MediaCategory(
      id: 'video_documentaries',
      titleKey: 'media_video_documentaries',
      type: MediaType.video,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'video_performances',
      titleKey: 'media_video_performances',
      type: MediaType.video,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    // Photo categories
    MediaCategory(
      id: 'photos_historical_sites',
      titleKey: 'media_photos_historical_sites',
      type: MediaType.photo,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaCategory(
      id: 'photos_people_culture',
      titleKey: 'media_photos_people_culture',
      type: MediaType.photo,
      imageUrl: 'assets/images/placeholder_landscape.svg',
    ),
  ];

  List<MediaItem> fetchItems() => const [
    // Audio items
    MediaItem(
      id: 'song_1',
      title: 'Hadiya Song 1',
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.audio,
      categoryId: 'audio_hadiya_songs',
      mediaUrl: 'assets/audio/sample.mp3',
    ),
    MediaItem(
      id: 'song_2',
      title: 'Folk Song 1',
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.audio,
      categoryId: 'audio_folk_songs',
      mediaUrl: 'assets/audio/sample2.mp3',
    ),
    MediaItem(
      id: 'oral_1',
      title: "Elder's Tale 1",
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.audio,
      categoryId: 'oral_elders_tales',
      mediaUrl: 'assets/audio/tale1.mp3',
    ),
    // Video items
    MediaItem(
      id: 'doc_1',
      title: 'Documentary Clip 1',
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.video,
      categoryId: 'video_documentaries',
      mediaUrl: 'assets/videos/doc1.mp4',
    ),
    MediaItem(
      id: 'perf_1',
      title: 'Cultural Performance 1',
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.video,
      categoryId: 'video_performances',
      mediaUrl: 'assets/videos/perf1.mp4',
    ),
    // Photos
    MediaItem(
      id: 'site_1',
      title: 'Historical Site 1',
      thumbnailUrl: 'assets/images/placeholder_landscape.svg',
      type: MediaType.photo,
      categoryId: 'photos_historical_sites',
      mediaUrl: 'assets/images/placeholder_landscape.svg',
    ),
    MediaItem(
      id: 'people_1',
      title: 'Cultural Portrait 1',
      thumbnailUrl: 'assets/images/portrait_placeholder.svg',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/portrait_placeholder.svg',
    ),
  ];
}
