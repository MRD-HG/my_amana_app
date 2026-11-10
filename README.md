# My Amana (Barid Al-Maghrib) — PFE Flutter App

![Flutter CI](https://github.com/MRD-HG/my_amana_app/actions/workflows/flutter_ci.yml/badge.svg)

This version runs **without Firebase** (fully offline demo).

✅ Data source:
- **Static Moroccan demo data** in `assets/data/*.json` (agencies, shipments, offers, demo users).
- **User-generated data** (support tickets, feedback, contact messages, pre-shipments, facteur status updates) stored locally via **SharedPreferences**.

## Quick start

```bash
flutter pub get
flutter test          # unit tests (tarif, tracking stages, facteur auth)
flutter run
```

### Google Maps (agencies screen)

The map is disabled unless an API key is provided (a list fallback is shown):

```bash
# Android: android/gradle.properties (or ~/.gradle/gradle.properties)
MAPS_API_KEY=your_key
# Dart side
flutter run --dart-define=MAPS_API_KEY=your_key
```

### Release build (Android)

Create `android/key.properties` (git-ignored) with `storeFile`, `storePassword`,
`keyAlias`, `keyPassword`, then `flutter build appbundle`. Without it the release
build is signed with the debug key (testing only).

## Demo credentials (Facteur space)

- Email: `facteur.rabat@amana.ma`  Password: `123456`
- Email: `facteur.marrakech@amana.ma`  Password: `123456`
- Email: `facteur.tanger@amana.ma`  Password: `123456`

## Tracking demo codes

Try in the tracking screen:
- `AMNMA240001`
- `AMNMA240002`
- `AMNMA240003`
- `AMNMA240004`
- `AMNINT240005`

## Where to edit the local data

- Agencies: `assets/data/agencies_ma.json`
- Shipments + tracking timeline: `assets/data/shipments_ma.json`
- Offers/news: `assets/data/offers_ma.json`
- Demo users (facteur login): `assets/data/users_ma.json`

> Tip: if you change any JSON in `assets/data/`, do a full restart so Flutter reloads assets.

## Limitations (demo scope)

- Demo credentials are stored in plain text in `assets/data/users_ma.json` and
  checked on the device — fine for a PFE demo, **not** real authentication.
- Tariffs from `TarifService` are illustrative estimates, not official prices.
