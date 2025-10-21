import 'package:flutter/material.dart';

/// Lightweight Map-based localizations for early development.
/// For production, migrate to ARB/intl workflow.
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const supportedLocales = [
    Locale('hdy'), // Hadiyigna placeholder
    Locale('am'), // Amharic
    Locale('en'), // English
  ];

  static const _localizedStrings = <String, Map<String, String>>{
    'welcome_title': {
      'hdy': 'Hadiya Heritage tiya', // TODO: verify translation
      'am': 'እንኳን ወደ ሐዲያ ቅርስ ተቀበሉ',
      'en': 'Welcome to Hadiya Heritage',
    },
    'welcome_subtitle': {
      'hdy': 'Hadiya seera, seena, hooda fi aadaa…', // TODO: verify
      'am': 'የሐዲያ ታሪክ፣ ባህል፣ ልምዶች እና ታላቅ ግለሰቦችን ያሳዩ',
      'en':
          'Explore the rich history, culture, traditions, and inspiring figures of the Hadiya people of Ethiopia.',
    },
    'select_language': {
      'hdy': 'Afaan filadhu', // TODO: verify
      'am': 'ቋንቋዎን ይምረጡ',
      'en': 'Select Your Language',
    },
    'continue': {
      'hdy': 'Itti fufi', // TODO: verify
      'am': 'ቀጥል',
      'en': 'Continue',
    },
    'hadiyigna': {'hdy': 'Hadiyigna', 'am': 'ሐዲያኛ', 'en': 'Hadiyigna'},
    'amharic': {'hdy': 'Amharic', 'am': 'አማርኛ', 'en': 'Amharic'},
    'english': {'hdy': 'English', 'am': 'እንግሊዝኛ', 'en': 'English'},
    // Home
    'story_of_week': {
      'hdy': 'Story of the Week', // TODO: verify
      'am': 'የሳምንቱ ታሪክ',
      'en': 'Story of the Week',
    },
    'home_history_title': {
      'hdy': 'Visiting Sites',
      'am': 'የጎብኝነት ቦታዎች',
      'en': 'Visiting Sites',
    },
    'home_history_sub': {
      'hdy': 'Explore the rich history of the Hadiya people.',
      'am': 'የሐዲያ ታሪክን ይመልከቱ።',
      'en': 'Explore the rich history of the Hadiya people.',
    },
    'home_culture_title': {
      'hdy': 'Culture & Traditions',
      'am': 'ባህል እና ልማዶች',
      'en': 'Culture & Traditions',
    },
    'home_culture_sub': {
      'hdy': 'Discover unique cultural practices.',
      'am': 'የብቸኛ ባህላዊ ልማዶችን ያግኙ።',
      'en': 'Discover unique cultural practices.',
    },
    'home_sites_title': {
      'hdy': 'Historical Sites',
      'am': 'ታሪካዊ ቦታዎች',
      'en': 'Historical Sites',
    },
    'home_sites_sub': {
      'hdy': 'Visit significant historical sites.',
      'am': 'ጠቃሚ ታሪካዊ ቦታዎችን ይጎብኙ።',
      'en': 'Visit significant historical sites.',
    },
    'home_persons_title': {
      'hdy': 'Famous Persons',
      'am': 'ታዋቂ ሰዎች',
      'en': 'Famous Persons',
    },
    'home_persons_sub': {
      'hdy': 'Learn about influential figures.',
      'am': 'ተፅእኖ ያላቸውን ግለሰቦች ያውቁ።',
      'en': 'Learn about influential figures.',
    },
    'home_festivals_title': {
      'hdy': 'Festivals',
      'am': 'በዓላት',
      'en': 'Festivals',
    },
    'home_festivals_sub': {
      'hdy': 'Experience vibrant celebrations.',
      'am': 'በርቷ የሆኑ ክብረ በዓላትን ያስተምሩ።',
      'en': 'Experience vibrant celebrations.',
    },
    'home_audio_title': {
      'hdy': 'Audio-Stories',
      'am': 'የድምጽ ታሪኮች',
      'en': 'Audio-Stories',
    },
    'home_audio_sub': {
      'hdy': 'Listen to traditional stories.',
      'am': 'የባህላዊ ታሪኮችን ያዳምጡ።',
      'en': 'Listen to traditional stories.',
    },
    // History timeline
    'hadiya_history': {
      'hdy': 'Hadiya Visiting Sites',
      'am': 'የሐዲያ የጎብኝነት ቦታዎች',
      'en': 'Hadiya Visiting Sites',
    },
    'history_pre_state_title': {
      'hdy': 'Kelalamo',
      'am': 'ከላላሞ',
      'en': 'Kelalamo',
    },
    'history_pre_state_sub': {
      'hdy': 'Historic site with ancient structures',
      'am': 'የጥንታዊ አወቃቀሮች ታሪካዊ ቦታ',
      'en': 'Historic site with ancient structures',
    },
    'history_sultanate_title': {
      'hdy': 'Mechefera',
      'am': 'መቸፈራ',
      'en': 'Mechefera',
    },
    'history_sultanate_sub': {
      'hdy': 'Cultural heritage site and landmark',
      'am': 'የባህል ቅርስ ቦታ እና ምልክት',
      'en': 'Cultural heritage site and landmark',
    },
    'history_adal_title': {
      'hdy': 'Hadiya Nafara',
      'am': 'ሐዲያ ናፋራ',
      'en': 'Hadiya Nafara',
    },
    'history_adal_sub': {
      'hdy': 'Traditional gathering and cultural site',
      'am': 'ባህላዊ የስብሰባ እና የባህል ቦታ',
      'en': 'Traditional gathering and cultural site',
    },
    'history_modern_title': {
      'hdy': 'Hadiya Nefera',
      'am': 'ሐዲያ ነፈራ',
      'en': 'Hadiya Nefera',
    },
    'history_modern_sub': {
      'hdy': 'Scenic natural beauty and landscape',
      'am': 'መልከዓማዊ ተፈጥሯዊ ውበት እና መልክዓ ምድራዊ አቀማመጥ',
      'en': 'Scenic natural beauty and landscape',
    },
    'history_contemporary_title': {
      'hdy': 'Kelalamo Heritage',
      'am': 'ከላላሞ ቅርስ',
      'en': 'Kelalamo Heritage',
    },
    'history_contemporary_sub': {
      'hdy': 'Protected heritage site and monument',
      'am': 'የተጠበቀ የቅርስ ቦታ እና ሀውልት',
      'en': 'Protected heritage site and monument',
    },
    // Culture & Traditions
    'hadiya_culture_title': {
      'hdy': 'Hadiya Culture & Traditions',
      'am': 'የሐዲያ ባህል እና ልማዶች',
      'en': 'Hadiya Culture & Traditions',
    },
    'culture_language_title': {
      'hdy': 'Language',
      'am': 'ቋንቋ',
      'en': 'Language',
    },
    'culture_language_body': {
      'hdy': 'Hadiyigna information placeholder. TODO: verify and enrich.',
      'am': 'ሐዲያኛ የሐዲያ ሕዝብ ዋና ቋንቋ ነው። የተለያዩ ዝርያዎች አሉት።',
      'en':
          'Hadiyigna is the native language of the Hadiya people, belonging to the Cushitic branch of the Afroasiatic family. It is a symbol of unity and identity, spoken by hundreds of thousands in southern Ethiopia. The language features several dialects, reflecting the diversity within Hadiya communities. Oral tradition, poetry, and storytelling are vital in preserving history and values, with elders passing down wisdom through generations. Efforts to document and teach Hadiyigna in schools are ongoing, helping to safeguard this rich linguistic heritage.',
    },
    'culture_music_title': {
      'hdy': 'Music & Dance',
      'am': 'ሙዚቃ እና ዳንስ',
      'en': 'Music & Dance',
    },
    'culture_music_body': {
      'hdy': 'Music & dance placeholder. TODO: verify.',
      'am': 'ሙዚቃና ዳንስ በሕይወት ውስጥ አስፈላጊ ሚና አላቸው።',
      'en':
          'Music and dance are the heartbeat of Hadiya celebrations, marking weddings, harvests, and religious festivals. Traditional instruments like the masenqo (single-stringed fiddle), drums, and flutes accompany vibrant dances, each with unique steps and meanings. Songs recount historical events, praise ancestors, and express emotions from joy to sorrow. Dance circles foster community spirit, with participants wearing colorful attire and moving in harmony. These art forms are not only entertainment but also a living archive of Hadiya history and values.',
    },
    'culture_customs_title': {'hdy': 'Customs', 'am': 'ልማዶች', 'en': 'Customs'},
    'culture_customs_body': {
      'hdy': 'Customs placeholder. TODO: verify.',
      'am': 'ልማዶች የዕለት ተዕለት ተግባራትን ይመራሉ።',
      'en':
          'Hadiya customs emphasize respect for elders, hospitality, and communal support. Ceremonies such as weddings and funerals are elaborate, involving extended families and neighbors. The practice of sharing food, especially during holidays, strengthens bonds. Elders mediate disputes and guide important decisions, ensuring harmony. Rituals mark life stages, from birth to adulthood, with blessings and symbolic gifts. These customs foster a sense of belonging and continuity, connecting individuals to their heritage and community.',
    },
    'culture_social_title': {
      'hdy': 'Social Structure',
      'am': 'ማህበራዊ መዋቅር',
      'en': 'Social Structure',
    },
    'culture_social_body': {
      'hdy': 'Social structure placeholder. TODO: verify.',
      'am': 'ማህበራዊ መዋቅር በጎሳ እና በሴራ ስርዓት ይመራል።',
      'en':
          'Hadiya society is structured around clans (gosa), each tracing lineage to a common ancestor. The Sera system governs roles, responsibilities, and conflict resolution, promoting fairness and cooperation. Leadership is often vested in elders and respected figures, who oversee rituals and community affairs. Social gatherings, mutual aid, and collective farming are common, reflecting the value placed on unity and shared purpose. This structure has helped the Hadiya people maintain resilience and identity through changing times.',
    },
    // Icons (Leaders, Warriors, Cultural Icons)
    'icons_title': {
      'hdy': 'Hadiya Icons',
      'am': 'የሐዲያ ታላቅ ፊጣሪዎች',
      'en': 'Hadiya Icons',
    },
    'icons_search_hint': {
      'hdy': 'Search for Hadiya icons',
      'am': 'ለሐዲያ ፊጣሪዎች ይፈልጉ',
      'en': 'Search for Hadiya icons',
    },
    'icons_leaders': {'hdy': 'Leaders', 'am': 'መሪዎች', 'en': 'Leaders'},
    'icons_warriors': {'hdy': 'Warriors', 'am': 'ተዋጊዎች', 'en': 'Warriors'},
    'icons_cultural': {
      'hdy': 'Cultural Icons',
      'am': 'የባህል ፊጣሪዎች',
      'en': 'Cultural Icons',
    },
    'icon_garad_aze': {'hdy': 'Garad Aze', 'am': 'ጋራድ አዜ', 'en': 'Garad Aze'},
    'icon_garad_sidi_mohammed': {
      'hdy': 'Garad Sidi Mohammed',
      'am': 'ጋራድ ሲዲ መሐመድ',
      'en': 'Garad Sidi Mohammed',
    },
    'icon_nigist_eleni': {
      'hdy': 'Nigist Eleni',
      'am': 'ንግስት እሌኒ',
      'en': 'Queen Eleni',
    },
    'icon_professor_beyene': {
      'hdy': 'Professor Beyene',
      'am': 'ፕሮፌሰር በየነ',
      'en': 'Professor Beyene',
    },
    'icon_warrior_1': {'hdy': 'Warrior 1', 'am': 'ተዋጊ 1', 'en': 'Warrior 1'},
    'icon_warrior_2': {'hdy': 'Warrior 2', 'am': 'ተዋጊ 2', 'en': 'Warrior 2'},
    'icon_cultural_1': {
      'hdy': 'Cultural Icon 1',
      'am': 'የባህል ፊጣሪ 1',
      'en': 'Cultural Icon 1',
    },
    'icon_cultural_2': {
      'hdy': 'Cultural Icon 2',
      'am': 'የባህል ፊጣሪ 2',
      'en': 'Cultural Icon 2',
    },
    'icon_leader_18c': {
      'hdy': '18th Century Leader',
      'am': 'የ18ኛው ክ/ዘመን መሪ',
      'en': '18th Century Leader',
    },
    'icon_leader_19c': {
      'hdy': '19th Century Leader',
      'am': 'የ19ኛው ክ/ዘመን መሪ',
      'en': '19th Century Leader',
    },
    'icon_leader_15c': {
      'hdy': '15th Century Leader',
      'am': 'የ15ኛው ክ/ዘመን መሪ',
      'en': '15th Century Leader',
    },
    'icon_leader_20c': {
      'hdy': '20th Century Leader',
      'am': 'የ20ኛው ክ/ዘመን መሪ',
      'en': '20th Century Leader',
    },

    'icon_warrior_19c': {
      'hdy': '19th Century Warrior',
      'am': 'የ19ኛው ክ/ዘመን ተዋጊ',
      'en': '19th Century Warrior',
    },
    'icon_warrior_20c': {
      'hdy': '20th Century Warrior',
      'am': 'የ20ኛው ክ/ዘመን ተዋጊ',
      'en': '20th Century Warrior',
    },
    'icon_cultural_20c': {
      'hdy': '20th Century Icon',
      'am': 'የ20ኛው ክ/ዘመን ፊጣሪ',
      'en': '20th Century Icon',
    },
    'icon_cultural_21c': {
      'hdy': '21st Century Icon',
      'am': 'የ21ኛው ክ/ዘመን ፊጣሪ',
      'en': '21st Century Icon',
    },
    // Calendar (Festivals)
    'calendar_title': {
      'hdy': 'Hadiya Calendar',
      'am': 'የሐዲያ የቀን መቁጠሪያ',
      'en': 'Hadiya Calendar',
    },
    'upcoming_events': {
      'hdy': 'Upcoming Events',
      'am': 'ቀረቡ የሚመጡ ክስተቶች',
      'en': 'Upcoming Events',
    },
    'festival_hossana': {
      'hdy': 'Hossana Festival',
      'am': 'የሆሳዕና በዓል',
      'en': 'Hossana Festival',
    },
    'festival_new_year': {
      'hdy': 'Hadiya New Year',
      'am': 'የሐዲያ አዲስ አመት',
      'en': 'Hadiya New Year',
    },
    // Settings
    'settings_title': {'hdy': 'Settings', 'am': 'ቅንብሮች', 'en': 'Settings'},
    'settings_general': {'hdy': 'General', 'am': 'አጠቃላይ', 'en': 'General'},
    'settings_language': {'hdy': 'Language', 'am': 'ቋንቋ', 'en': 'Language'},
    'settings_language_value': {
      'hdy': 'English',
      'am': 'እንግሊዝኛ',
      'en': 'English',
    },
    'settings_offline_title': {
      'hdy': 'Offline Access',
      'am': 'ከመስመር ውጭ መዳሰስ',
      'en': 'Offline Access',
    },
    'settings_offline_sub': {
      'hdy': 'Enable offline access to content',
      'am': 'ይዘቶችን ከመስመር ውጭ ለመዳሰስ አንቀሳቅስ',
      'en': 'Enable offline access to content',
    },
    'settings_notifications': {
      'hdy': 'Notifications',
      'am': 'ማሳወቂያዎች',
      'en': 'Notifications',
    },
    'settings_notifications_sub': {
      'hdy': 'Manage notification preferences',
      'am': 'የማሳወቂያ ምርጫዎችን ያቀናብሩ',
      'en': 'Manage notification preferences',
    },
    'settings_account': {'hdy': 'Account', 'am': 'መለያ', 'en': 'Account'},
    'settings_account_details': {
      'hdy': 'Account Details',
      'am': 'የመለያ ዝርዝሮች',
      'en': 'Account Details',
    },
    'settings_account_details_sub': {
      'hdy': 'Manage your account details',
      'am': 'የመለያዎን ዝርዝሮች ያስተዳድሩ',
      'en': 'Manage your account details',
    },
    'settings_about': {'hdy': 'About', 'am': 'ስለ መተግበሪያው', 'en': 'About'},
    'settings_about_us': {'hdy': 'About Us', 'am': 'ስለ እኛ', 'en': 'About Us'},
    'settings_about_us_sub': {
      'hdy': "Learn about the app's mission",
      'am': 'የመተግበሪያውን ዓላማ ይወቁ',
      'en': "Learn about the app's mission",
    },
    'settings_credits': {
      'hdy': 'Credits',
      'am': 'ምንጮች እና ሰራተኞች',
      'en': 'Credits',
    },
    'settings_credits_sub': {
      'hdy': 'View content sources and contributors',
      'am': 'የይዘት ምንጮችን እና አበርካቾችን ይመልከቱ',
      'en': 'View content sources and contributors',
    },
    // Media Gallery
    'media_gallery_title': {
      'hdy': 'Media Gallery',
      'am': 'ሚዲያ ጋለሪ',
      'en': 'Media Gallery',
    },
    'media_tab_audio': {'hdy': 'Audio', 'am': 'ድምጽ', 'en': 'Audio'},
    'media_tab_video': {'hdy': 'Video', 'am': 'ቪዲዮ', 'en': 'Video'},
    'media_tab_photos': {'hdy': 'Photos', 'am': 'ፎቶዎች', 'en': 'Photos'},
    'media_audio_title': {'hdy': 'Audio', 'am': 'ድምጽ', 'en': 'Audio'},
    'media_video_title': {'hdy': 'Video', 'am': 'ቪዲዮ', 'en': 'Video'},
    'media_photos_title': {'hdy': 'Photos', 'am': 'ፎቶዎች', 'en': 'Photos'},
    // Media categories
    'media_audio_hadiya_songs': {
      'hdy': 'Hadiya Songs',
      'am': 'የሐዲያ መዝሙሮች',
      'en': 'Hadiya Songs',
    },
    'media_audio_folk_songs': {
      'hdy': 'Folk Songs',
      'am': 'የሕዝብ መዝሙሮች',
      'en': 'Folk Songs',
    },
    'media_audio_cultural_music': {
      'hdy': 'Cultural Music',
      'am': 'ባህላዊ ሙዚቃ',
      'en': 'Cultural Music',
    },
    'media_audio_elders_tales': {
      'hdy': "Elder's Tales",
      'am': 'የአሮጌዎች ታሪኮች',
      'en': "Elder's Tales",
    },
    'media_audio_leaders_stories': {
      'hdy': "Leaders' Stories",
      'am': 'የመሪዎች ታሪኮች',
      'en': "Leaders' Stories",
    },
    'media_video_documentaries': {
      'hdy': 'Documentaries',
      'am': 'ሰነዶች',
      'en': 'Documentaries',
    },
    'media_video_performances': {
      'hdy': 'Performances',
      'am': 'ተከናዎች',
      'en': 'Performances',
    },
    'media_photos_historical_sites': {
      'hdy': 'Historical Sites',
      'am': 'ታሪካዊ ቦታዎች',
      'en': 'Historical Sites',
    },
    'media_photos_people_culture': {
      'hdy': 'People & Culture',
      'am': 'ሰዎች እና ባህል',
      'en': 'People & Culture',
    },
    // Historical sites (names and subtitles)
    'site_chebera_name': {
      'hdy': 'Chebera Churchura National Park',
      'am': 'የቸበራ ቹርቹራ ናሽናል ፓርክ',
      'en': 'Chebera Churchura National Park',
    },
    'site_chebera_sub': {
      'hdy': 'Diverse wildlife and stunning landscapes.',
      'am': 'በብዙ የዱር እንስሳት እና ተወዳጅ ተፈጥሯዊ መዓዛ የታወቀ።',
      'en': 'A vast park with diverse wildlife and stunning landscapes.',
    },
    'site_wonchi_name': {
      'hdy': 'Lake Wonchi',
      'am': 'ወንጭ ሐይቅ',
      'en': 'Lake Wonchi',
    },
    'site_wonchi_sub': {
      'hdy': 'Crater lake with hot springs and monastery.',
      'am': 'በሙቀት የሚፈስ ውሃ እና መካከለኛ ገዳም ያለው ክሬተር ሐይቅ።',
      'en': 'A crater lake with hot springs and a monastery.',
    },
    'site_tiya_name': {
      'hdy': 'Tiya Stones',
      'am': 'ጢያ ድንጋዮች',
      'en': 'Tiya Stones',
    },
    'site_tiya_sub': {
      'hdy': 'UNESCO World Heritage stelae site.',
      'am': 'የዩኔስኮ የዓለም ቅርስ ድንጋዮች ቦታ።',
      'en': 'A UNESCO World Heritage site with ancient stelae.',
    },
    'site_adadi_name': {
      'hdy': 'Adadi Mariam',
      'am': 'አዳዲ ማርያም',
      'en': 'Adadi Mariam',
    },
    'site_adadi_sub': {
      'hdy': 'Rock-hewn church similar to Lalibela.',
      'am': 'ለሊበላን የሚመስል ከድንጋይ የተቆረጠ ቤተ ክርስቲያን።',
      'en': 'A rock-hewn church similar to those in Lalibela.',
    },
    // AI Chat
    'chat_title': {
      'hdy': 'Hadiya Assistant',
      'am': 'የሐዲያ አስተዋዋቂ',
      'en': 'Hadiya Assistant',
    },
    'chat_input_hint': {
      'hdy': 'Ask me anything about Hadiya...',
      'am': 'ስለ ሐዲያ ማንኛውንም ይጠይቁ...',
      'en': 'Ask me anything about Hadiya...',
    },
    'chat_welcome_title': {
      'hdy': 'Welcome to Hadiya Assistant!',
      'am': 'እንኳን ደህና መጡ ወደ ሐዲያ አስተዋዋቂ!',
      'en': 'Welcome to Hadiya Assistant!',
    },
    'chat_welcome_subtitle': {
      'hdy':
          'I am here to help you explore the rich heritage, culture, and history of the Hadiya people. Ask me anything!',
      'am': 'የሐዲያ ሕዝብን ሀብታም ቅርስ፣ ባህል እና ታሪክ ለማስተዋወቅ እዚህ ነኝ። ማንኛውንም ይጠይቁ!',
      'en':
          'I am here to help you explore the rich heritage, culture, and history of the Hadiya people. Ask me anything!',
    },
    'chat_suggestions_title': {
      'hdy': 'Try asking about:',
      'am': 'ስለ እነዚህ ይጠይቁ:',
      'en': 'Try asking about:',
    },
    'chat_feature_history': {
      'hdy': 'History & Heritage',
      'am': 'ታሪክ እና ቅርስ',
      'en': 'History & Heritage',
    },
    'chat_feature_history_desc': {
      'hdy': 'Learn about ancient Hadiya kingdoms and historical events',
      'am': 'ስለ ጥንታዊ የሐዲያ መንግሥታት እና ታሪካዊ ክስተቶች ይወቁ',
      'en': 'Learn about ancient Hadiya kingdoms and historical events',
    },
    'chat_feature_culture': {
      'hdy': 'Culture & Traditions',
      'am': 'ባህል እና ልማዶች',
      'en': 'Culture & Traditions',
    },
    'chat_feature_culture_desc': {
      'hdy': 'Discover festivals, customs, music, and language',
      'am': 'በዓላትን፣ ልማዶችን፣ ሙዚቃን እና ቋንቋን ያግኙ',
      'en': 'Discover festivals, customs, music, and language',
    },
    'chat_feature_places': {
      'hdy': 'Places to Visit',
      'am': 'የጎብኚነት ቦታዎች',
      'en': 'Places to Visit',
    },
    'chat_feature_places_desc': {
      'hdy': 'Get recommendations for historical sites and attractions',
      'am': 'ለታሪካዊ ቦታዎች እና መስህቦች ምክሮችን ያግኙ',
      'en': 'Get recommendations for historical sites and attractions',
    },
    'chat_feature_help': {
      'hdy': 'App Navigation',
      'am': 'የመተግበሪያ አሰሳ',
      'en': 'App Navigation',
    },
    'chat_feature_help_desc': {
      'hdy': 'Learn how to use app features and find content',
      'am': 'የመተግበሪያ ባህሪያትን እንዴት እንደሚጠቀሙ እና ይዘቶችን እንዴት እንደሚያገኙ ይወቁ',
      'en': 'Learn how to use app features and find content',
    },
    'chat_clear': {'hdy': 'Clear Chat', 'am': 'ውይይት አፅዳ', 'en': 'Clear Chat'},
    'chat_clear_dialog_title': {
      'hdy': 'Clear Chat History?',
      'am': 'የውይይት ታሪክ ይፅዳ?',
      'en': 'Clear Chat History?',
    },
    'chat_clear_dialog_message': {
      'hdy': 'This will permanently delete all messages in this conversation.',
      'am': 'ይህ በዚህ ውይይት ውስጥ ያሉትን ሁሉንም መልዕክቶች በቋሚነት ይሰርዛል።',
      'en': 'This will permanently delete all messages in this conversation.',
    },
    'cancel': {'hdy': 'Cancel', 'am': 'ሰርዝ', 'en': 'Cancel'},
  };

  String t(String key) =>
      _localizedStrings[key]?[locale.languageCode] ??
      _localizedStrings[key]?['en'] ??
      key;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocDelegate();
}

class _AppLocDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocDelegate();
  @override
  bool isSupported(Locale locale) =>
      ['hdy', 'am', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
