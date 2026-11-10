class AppConfig {
  static const String mapsApiKey =
      String.fromEnvironment('MAPS_API_KEY', defaultValue: '');

  static bool get mapsEnabled => mapsApiKey.isNotEmpty;
}

/// SharedPreferences key set once the user finished the onboarding flow.
const String kOnboardingDoneKey = 'onboarding_done_v1';
