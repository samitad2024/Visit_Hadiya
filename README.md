# Hadiya Heritage  Android App

A cross‑platform Flutter app to showcase the culture, history, sites, and biographies of the Hadiya people (Hossana, Ethiopia). Built with Provider state management, clean feature folders, and early localization support.

## Features (MVP)
- Welcome + language selection (Hadiyigna, Amharic, English placeholders)
- Home sections with categories
- History Timeline screen with mock data and placeholders
- Device Preview enabled on web to emulate mobile frames

## Tech
- Flutter 3.x, Dart
- Provider for state management
- google_fonts, flutter_svg, intl, flutter_localizations

Device Preview: Runs automatically in debug; you can switch devices from the Device Preview panel in the app (Chrome).

## Project structure
- `lib/ui/screens/` — Screens (Welcome, Home, HistoryTimeline)
- `lib/controllers/` — ChangeNotifier controllers per feature
- `lib/data/mock/` — Mock repositories/data
- `lib/models/` — Domain models
- `lib/l10n/` — Lightweight map-based localization (migrate to ARB later)
- `lib/core/theme/` — Theme and colors

## Localization
Early development uses simple map-based texts. Replace with ARB/intl for production. Hadiyigna strings are placeholders with TODO: verify.

## Assets & Credits
All images are placeholders (SVG). Replace with verified graphics/media before release.


---
This repository follows the blueprint in `blueprint.md` — accuracy first, culturally respectful content, and offline-friendly design.
