import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: const Color(AppColors.primary),
    primary: const Color(AppColors.primary),
    surface: isDark ? const Color(0xFF0F1115) : const Color(AppColors.surface),
  );

  final baseTextTheme = GoogleFonts.nunitoTextTheme();

  final textTheme = baseTextTheme.copyWith(
    displayLarge: baseTextTheme.displayLarge?.copyWith(
      fontWeight: FontWeight.w800,
      color: Color(isDark ? 0xFFF3F4F6 : AppColors.textPrimary),
    ),
    displayMedium: baseTextTheme.displayMedium?.copyWith(
      fontWeight: FontWeight.w700,
      color: Color(isDark ? 0xFFF3F4F6 : AppColors.textPrimary),
    ),
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.w700,
      color: Color(isDark ? 0xFFF3F4F6 : AppColors.textPrimary),
    ),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(
      color: const Color(AppColors.textSecondary),
      height: 1.5,
    ),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(
      color: const Color(AppColors.textSecondary),
      height: 1.5,
    ),
  );

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Color(AppColors.outline)),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: isDark
        ? const Color(0xFF0B0D10)
        : const Color(AppColors.background),
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark
          ? const Color(0xFF0B0D10)
          : const Color(AppColors.background),
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: inputBorder,
      border: inputBorder,
      focusedBorder: inputBorder.copyWith(
        borderSide: const BorderSide(color: Color(AppColors.primary), width: 2),
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    dividerColor: const Color(AppColors.outline),
  );
}
