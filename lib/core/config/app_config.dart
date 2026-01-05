class AppConfig {
  static const String mapsApiKey =
      String.fromEnvironment('MAPS_API_KEY', defaultValue: '');

  static bool get mapsEnabled => mapsApiKey.isNotEmpty;
}
