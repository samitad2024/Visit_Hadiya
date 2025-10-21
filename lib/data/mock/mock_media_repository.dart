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
      imageUrl: 'assets/images/hadiy_nefera.png',
    ),
    MediaCategory(
      id: 'audio_folk_songs',
      titleKey: 'media_audio_folk_songs',
      type: MediaType.audio,
      imageUrl: 'assets/images/kelalamo.png',
    ),
    MediaCategory(
      id: 'audio_cultural_music',
      titleKey: 'media_audio_cultural_music',
      type: MediaType.audio,
      imageUrl: 'assets/images/hadiya_women.png',
    ),
    MediaCategory(
      id: 'oral_elders_tales',
      titleKey: 'media_audio_elders_tales',
      type: MediaType.audio,
      imageUrl: 'assets/images/old_hadiya_women.png',
    ),
    // Video categories
    MediaCategory(
      id: 'video_documentaries',
      titleKey: 'media_video_documentaries',
      type: MediaType.video,
      imageUrl: 'assets/images/tiya_stones.jpg',
    ),
    MediaCategory(
      id: 'video_performances',
      titleKey: 'media_video_performances',
      type: MediaType.video,
      imageUrl: 'assets/images/artists.png',
    ),
    // Photo categories
    MediaCategory(
      id: 'photos_historical_sites',
      titleKey: 'media_photos_historical_sites',
      type: MediaType.photo,
      imageUrl: 'assets/images/chebera_churchura.jpg',
    ),
    MediaCategory(
      id: 'photos_people_culture',
      titleKey: 'media_photos_people_culture',
      type: MediaType.photo,
      imageUrl: 'assets/images/artist_collection.png',
    ),
  ];

  List<MediaItem> fetchItems() => const [
    // ===== HADIYA SONGS =====
    MediaItem(
      id: 'hadiya_song_1',
      title: 'Hadiya Traditional Song',
      subtitle: 'Traditional Hadiya Music',
      thumbnailUrl: 'assets/images/hadiy_nefera.png',
      type: MediaType.audio,
      categoryId: 'audio_hadiya_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    ),
    MediaItem(
      id: 'hadiya_song_2',
      title: 'Hadiya Cultural Melody',
      subtitle: 'Heritage Music Collection',
      thumbnailUrl: 'assets/images/hadiy_nafara_two.png',
      type: MediaType.audio,
      categoryId: 'audio_hadiya_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    ),
    MediaItem(
      id: 'hadiya_song_3',
      title: 'Hadiya Celebration Song',
      subtitle: 'Festival Music',
      thumbnailUrl: 'assets/images/kelalamo.png',
      type: MediaType.audio,
      categoryId: 'audio_hadiya_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    ),
    MediaItem(
      id: 'hadiya_song_4',
      title: 'Hadiya Dance Music',
      subtitle: 'Traditional Dance',
      thumbnailUrl: 'assets/images/mechefera.png',
      type: MediaType.audio,
      categoryId: 'audio_hadiya_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
    ),

    // ===== FOLK SONGS =====
    MediaItem(
      id: 'folk_song_1',
      title: 'Ethiopian Folk Song',
      subtitle: 'Classic Folk Music',
      thumbnailUrl: 'assets/images/hadiya_women.png',
      type: MediaType.audio,
      categoryId: 'audio_folk_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
    ),
    MediaItem(
      id: 'folk_song_2',
      title: 'Village Traditional Song',
      subtitle: 'Rural Folk Music',
      thumbnailUrl: 'assets/images/old_hadiya_women.png',
      type: MediaType.audio,
      categoryId: 'audio_folk_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
    ),
    MediaItem(
      id: 'folk_song_3',
      title: 'Harvest Song',
      subtitle: 'Agricultural Tradition',
      thumbnailUrl: 'assets/images/artists.png',
      type: MediaType.audio,
      categoryId: 'audio_folk_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
    ),
    MediaItem(
      id: 'folk_song_4',
      title: 'Wedding Folk Song',
      subtitle: 'Celebration Music',
      thumbnailUrl: 'assets/images/artist_collection.png',
      type: MediaType.audio,
      categoryId: 'audio_folk_songs',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
    ),

    // ===== CULTURAL MUSIC =====
    MediaItem(
      id: 'cultural_1',
      title: 'Cultural Heritage Music',
      subtitle: 'Traditional Instruments',
      thumbnailUrl: 'assets/images/hadiy_nefera.png',
      type: MediaType.audio,
      categoryId: 'audio_cultural_music',
      mediaUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
    ),
    MediaItem(
      id: 'cultural_2',
      title: 'Ancient Hadiya Melody',
      subtitle: 'Historical Music',
      thumbnailUrl: 'assets/images/kelalamo.png',
      type: MediaType.audio,
      categoryId: 'audio_cultural_music',
      mediaUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
    ),
    MediaItem(
      id: 'cultural_3',
      title: 'Ceremonial Music',
      subtitle: 'Religious & Cultural',
      thumbnailUrl: 'assets/images/mechefera.png',
      type: MediaType.audio,
      categoryId: 'audio_cultural_music',
      mediaUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
    ),

    // ===== ELDERS TALES =====
    MediaItem(
      id: 'oral_1',
      title: "Elder's Wisdom Tale",
      subtitle: 'Traditional Story',
      thumbnailUrl: 'assets/images/old_hadiya_women.png',
      type: MediaType.audio,
      categoryId: 'oral_elders_tales',
      mediaUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
    ),
    MediaItem(
      id: 'oral_2',
      title: 'History Through Stories',
      subtitle: 'Oral History',
      thumbnailUrl: 'assets/images/professor_beyene.png',
      type: MediaType.audio,
      categoryId: 'oral_elders_tales',
      mediaUrl:
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
    ),

    // ===== VIDEO DOCUMENTARIES =====
    MediaItem(
      id: 'doc_1',
      title: 'Ethiopian Culture & Traditions',
      subtitle: 'Cultural Overview',
      thumbnailUrl: 'https://img.youtube.com/vi/7GfvK5r38qY/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_documentaries',
      mediaUrl: '7GfvK5r38qY', // Ethiopia Documentary
    ),
    MediaItem(
      id: 'doc_2',
      title: 'Hadiya Zone Documentary',
      subtitle: 'Regional History',
      thumbnailUrl: 'https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_documentaries',
      mediaUrl: 'dQw4w9WgXcQ', // Placeholder
    ),
    MediaItem(
      id: 'doc_3',
      title: 'Ethiopian Heritage Sites',
      subtitle: 'Historical Landmarks',
      thumbnailUrl: 'https://img.youtube.com/vi/9bZkp7q19f0/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_documentaries',
      mediaUrl: '9bZkp7q19f0', // Ethiopia Tourism
    ),

    // ===== VIDEO PERFORMANCES =====
    MediaItem(
      id: 'perf_1',
      title: 'Hinbongo - Ethiopian Music',
      subtitle: 'Hadiya Traditional Music',
      thumbnailUrl: 'https://img.youtube.com/vi/x2JTDCM_ywM/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_performances',
      mediaUrl: 'x2JTDCM_ywM', // Hinbongo
    ),
    MediaItem(
      id: 'perf_2',
      title: 'Workiaferahu Kebede',
      subtitle: 'Hadiya Music Performance',
      thumbnailUrl: 'https://img.youtube.com/vi/q9rKenMLEP4/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_performances',
      mediaUrl: 'q9rKenMLEP4', // Workiaferahu Kebede
    ),
    MediaItem(
      id: 'perf_3',
      title: 'Jelegiso X Gildo Kassa',
      subtitle: 'Hadiya Cultural Music',
      thumbnailUrl: 'https://img.youtube.com/vi/XlA9avJmyjQ/maxresdefault.jpg',
      type: MediaType.video,
      categoryId: 'video_performances',
      mediaUrl: 'XlA9avJmyjQ', // Jelegiso X Gildo Kassa
    ),

    // ===== PHOTOS - HISTORICAL SITES =====
    MediaItem(
      id: 'site_1',
      title: 'Tiya Stone Monuments',
      subtitle: 'UNESCO World Heritage Site',
      thumbnailUrl: 'assets/images/tiya_stones.jpg',
      type: MediaType.photo,
      categoryId: 'photos_historical_sites',
      mediaUrl: 'assets/images/tiya_stones.jpg',
    ),
    MediaItem(
      id: 'site_2',
      title: 'Adadi Mariam Church',
      subtitle: 'Ancient Rock-Hewn Church',
      thumbnailUrl: 'assets/images/adadi_mariam.jpg',
      type: MediaType.photo,
      categoryId: 'photos_historical_sites',
      mediaUrl: 'assets/images/adadi_mariam.jpg',
    ),
    MediaItem(
      id: 'site_3',
      title: 'Lake Wonchi',
      subtitle: 'Natural Heritage',
      thumbnailUrl: 'assets/images/lake_wonchi.jpg',
      type: MediaType.photo,
      categoryId: 'photos_historical_sites',
      mediaUrl: 'assets/images/lake_wonchi.jpg',
    ),
    MediaItem(
      id: 'site_4',
      title: 'Chebera Churchura National Park',
      subtitle: 'Wildlife & Nature',
      thumbnailUrl: 'assets/images/chebera_churchura.jpg',
      type: MediaType.photo,
      categoryId: 'photos_historical_sites',
      mediaUrl: 'assets/images/chebera_churchura.jpg',
    ),

    // ===== PHOTOS - PEOPLE & CULTURE =====
    MediaItem(
      id: 'people_1',
      title: 'Hadiya Traditional Dress',
      subtitle: 'Cultural Attire',
      thumbnailUrl: 'assets/images/hadiya_women.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/hadiya_women.png',
    ),
    MediaItem(
      id: 'people_2',
      title: 'Traditional Artists',
      subtitle: 'Cultural Performers',
      thumbnailUrl: 'assets/images/artists.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/artists.png',
    ),
    MediaItem(
      id: 'people_3',
      title: 'Hadiya Elders',
      subtitle: 'Community Leaders',
      thumbnailUrl: 'assets/images/old_hadiya_women.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/old_hadiya_women.png',
    ),
    MediaItem(
      id: 'people_4',
      title: 'Cultural Instruments',
      subtitle: 'Traditional Music',
      thumbnailUrl: 'assets/images/kelalamo.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/kelalamo.png',
    ),
    MediaItem(
      id: 'people_5',
      title: 'Hadiya Nefera',
      subtitle: 'Traditional Dance',
      thumbnailUrl: 'assets/images/hadiy_nefera.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/hadiy_nefera.png',
    ),
    MediaItem(
      id: 'people_6',
      title: 'Artist Collection',
      subtitle: 'Cultural Ensemble',
      thumbnailUrl: 'assets/images/artist_collection.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/artist_collection.png',
    ),
    MediaItem(
      id: 'people_7',
      title: 'Mechefera Dance',
      subtitle: 'Traditional Performance',
      thumbnailUrl: 'assets/images/mechefera.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/mechefera.png',
    ),
    MediaItem(
      id: 'people_8',
      title: 'Historical Leaders',
      subtitle: 'Fitawurari Geja Geribo',
      thumbnailUrl: 'assets/images/Fitawurari_Geja_Geribo.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/Fitawurari_Geja_Geribo.png',
    ),
    MediaItem(
      id: 'people_9',
      title: 'Colonel Bezabih Petros',
      subtitle: 'Historical Figure',
      thumbnailUrl: 'assets/images/colonel_bezabih_petros.png',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/colonel_bezabih_petros.png',
    ),
    MediaItem(
      id: 'people_10',
      title: 'Nigist Eleni',
      subtitle: 'Historical Queen',
      thumbnailUrl: 'assets/images/nigist_eleni.jpeg',
      type: MediaType.photo,
      categoryId: 'photos_people_culture',
      mediaUrl: 'assets/images/nigist_eleni.jpeg',
    ),
  ];
}
