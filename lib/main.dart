import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';

import 'core/providers/app_settings_provider.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'ui/screens/welcome_screen.dart';
import 'ui/screens/festival_home_screen.dart';
import 'ui/screens/history_timeline_screen.dart';
import 'ui/screens/culture_screen.dart';
import 'ui/screens/icons_screen.dart';
import 'ui/screens/calendar_screen.dart';
import 'ui/screens/settings_screen.dart';
import 'ui/screens/media_gallery_screen.dart';
import 'ui/screens/media_category_screen.dart';

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
      create: (_) => AppSettingsProvider(),
      child: Consumer<AppSettingsProvider>(
        builder: (context, settings, __) {
          // Show loading screen while settings are being loaded
          if (settings.isLoading) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hadiya Heritage - Visit Hadiya',

            // Apply theme based on settings
            theme: buildAppTheme(Brightness.light),
            darkTheme: buildAppTheme(Brightness.dark),
            themeMode: settings.flutterThemeMode,

            // Apply language based on settings
            locale: DevicePreview.locale(context) ?? settings.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
            ],

            builder: (context, widget) {
              // Apply text scale factor based on settings
              Widget app = MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaleFactor: settings.textScaleFactor),
                child: widget!,
              );

              // Apply DevicePreview wrapper
              return DevicePreview.appBuilder(context, app);
            },

            routes: {
              '/home': (_) => const FestivalHomeScreen(),
              '/history': (_) => const HistoryTimelineScreen(),
              '/culture': (_) => const CultureScreen(),
              '/icons': (_) => const IconsScreen(),
              '/calendar': (_) => const CalendarScreen(),
              '/settings': (_) => const SettingsScreen(),
              '/media': (_) => const MediaGalleryScreen(),
              '/media/category': (_) => const MediaCategoryScreen(),
            },
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
