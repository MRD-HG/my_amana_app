# my_amana_app

My Amana / Poste Maroc (PFE) Flutter application.

## Features
- Tracking (Suivi) with timeline and barcode/QR scan
- Agencies map with Morocco markers and search
- Tarif calculator with validation
- Contact and Feedback forms (Firestore or Demo Mode)
- Facteur mode: login, assigned shipments, update status timeline

## Demo Mode
The app starts in Demo Mode if Firebase initialization fails. Demo Mode uses
in-memory sample data for tracking, agencies, feedback, contact, and facteur.
No configuration is required.

## Firebase setup
1) Create a Firebase project.
2) Add an Android app with package name `com.example.my_amana_app`.
3) Download `google-services.json` and place it in `android/app/`.
4) Install FlutterFire CLI:
   `dart pub global activate flutterfire_cli`
5) Run:
   `flutterfire configure`
   This generates/updates `lib/firebase_options.dart`.
6) Run the app:
   `flutter clean && flutter pub get && flutter run`

## Maps setup (Android)
Google Maps requires an API key.

1) Create a key in Google Cloud Console with Maps SDK for Android enabled.
2) Add the key to `android/gradle.properties`:
   `MAPS_API_KEY=YOUR_KEY`
3) Run with the Dart define so the UI enables the map:
   `flutter run --dart-define=MAPS_API_KEY=YOUR_KEY`

If the key is missing, the app shows a safe fallback instead of crashing.

## Run
- `flutter clean`
- `flutter pub get`
- `flutter run`
