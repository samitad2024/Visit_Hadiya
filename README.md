# Hadiya Heritage (web + Android)

A cross‑platform Flutter app to showcase the culture, history, sites, and biographies of the Hadiya people (Hossana, Ethiopia). Built with Provider state management, clean feature folders, and early localization support.

## Features (MVP)
- Welcome + language selection (Hadiyigna, Amharic, English placeholders)
- Home sections with categories
- History Timeline screen with mock data and placeholders
- Device Preview enabled on web to emulate mobile frames

## Tech
- Flutter 3.x, Dart 3.x
- Provider for state management
- google_fonts, flutter_svg, intl, flutter_localizations

## Run
```powershell
flutter pub get
flutter run -d chrome
```

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

## Contributing
1. Create a feature branch
2. Add tests where relevant
3. Create a PR describing the change and screenshots

---
This repository follows the blueprint in `blueprint.md` — accuracy first, culturally respectful content, and offline-friendly design.
