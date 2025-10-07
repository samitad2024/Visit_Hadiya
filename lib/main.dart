import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'core/providers/locale_provider.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/history_timeline_screen.dart';
import 'ui/screens/culture_screen.dart';
import 'ui/screens/icons_screen.dart';
import 'ui/screens/calendar_screen.dart';
import 'ui/screens/settings_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !const bool.fromEnvironment('dart.vm.product'),
      builder: (context) => const HadiyaHeritageApp(),
    ),
  );
}

class HadiyaHeritageApp extends StatelessWidget {
  const HadiyaHeritageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (_, localeProvider, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hadiya Heritage',
            theme: buildAppTheme(Brightness.light),
            darkTheme: buildAppTheme(Brightness.dark),
            // Use DevicePreview locale when enabled; else provider
            locale: DevicePreview.locale(context) ?? localeProvider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              // Material & Widgets localization strings
              DefaultWidgetsLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],
            builder: DevicePreview.appBuilder,
            routes: {
              '/history': (_) => const HistoryTimelineScreen(),
              '/culture': (_) => const CultureScreen(),
              '/icons': (_) => const IconsScreen(),
              '/calendar': (_) => const CalendarScreen(),
              '/settings': (_) => const SettingsScreen(),
            },
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
