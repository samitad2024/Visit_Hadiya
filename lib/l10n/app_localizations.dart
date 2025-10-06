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
      'hdy': 'History Timeline',
      'am': 'የታሪክ መስመር',
      'en': 'History Timeline',
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
      'hdy': 'Hadiya History',
      'am': 'የሐዲያ ታሪክ',
      'en': 'Hadiya History',
    },
    'history_pre_state_title': {
      'hdy': 'Pre-State Era',
      'am': 'የመንግሥት በፊት ዘመን',
      'en': 'Pre-State Era',
    },
    'history_pre_state_sub': {
      'hdy': 'Early settlements and tribal structures',
      'am': 'የመጀመሪያ መኖሪያዎች እና የጎሳ አወቃቀሮች',
      'en': 'Early settlements and tribal structures',
    },
    'history_sultanate_title': {
      'hdy': 'Hadiya Sultanate',
      'am': 'የሐዲያ ሱልጣናት',
      'en': 'Hadiya Sultanate',
    },
    'history_sultanate_sub': {
      'hdy': 'Establishment and expansion of the Sultanate',
      'am': 'የሱልጣናቱ መመስረት እና መስፋት',
      'en': 'Establishment and expansion of the Sultanate',
    },
    'history_adal_title': {
      'hdy': 'Adal–Hadiya War',
      'am': 'የአዳል–ሐዲያ ጦርነት',
      'en': 'Adal–Hadiya War',
    },
    'history_adal_sub': {
      'hdy': 'Conflict with the Adal Sultanate',
      'am': 'ከአዳል ሱልጣናት ጋር ግጭት',
      'en': 'Conflict with the Adal Sultanate',
    },
    'history_modern_title': {
      'hdy': 'Modern Hadiya',
      'am': 'ዘመናዊ ሐዲያ',
      'en': 'Modern Hadiya',
    },
    'history_modern_sub': {
      'hdy': 'Integration into modern Ethiopia',
      'am': 'ወደ ዘመናዊ ኢትዮጵያ መዋሃድ',
      'en': 'Integration into modern Ethiopia',
    },
    'history_contemporary_title': {
      'hdy': 'Contemporary Hadiya',
      'am': 'ዘመናዊ ሐዲያ',
      'en': 'Contemporary Hadiya',
    },
    'history_contemporary_sub': {
      'hdy': 'Cultural preservation and development',
      'am': 'የባህል ጥበቃ እና እድገት',
      'en': 'Cultural preservation and development',
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
          'Hadiyigna, a Cushitic language, is central to Hadiya identity. Dialects vary across the region.',
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
          'Music and dance express joy, sorrow, and history in Hadiya culture.',
    },
    'culture_festivals_title': {
      'hdy': 'Festivals',
      'am': 'በዓላት',
      'en': 'Festivals',
    },
    'culture_festivals_body': {
      'hdy': 'Festivals placeholder. TODO: verify.',
      'am': 'ልዩ በዓላት ማኅበረሰቡን ያመቻቹ እና እምነቶችን ያሳያሉ።',
      'en': 'Festivals celebrate seasons, community bonds, and beliefs.',
    },
    'culture_customs_title': {'hdy': 'Customs', 'am': 'ልማዶች', 'en': 'Customs'},
    'culture_customs_body': {
      'hdy': 'Customs placeholder. TODO: verify.',
      'am': 'ልማዶች የዕለት ተዕለት ተግባራትን ይመራሉ።',
      'en':
          'Customs guide daily life, respect for elders, and community harmony.',
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
          'Society is organized around clans (gosa) and the Sera system of roles and responsibilities.',
    },
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
