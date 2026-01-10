import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// Small helper to load JSON files from assets.
class JsonAssetLoader {
  JsonAssetLoader._();

  static Future<dynamic> loadJson(String assetPath) async {
    final raw = await rootBundle.loadString(assetPath);
    return jsonDecode(raw);
  }

  static Future<List<dynamic>> loadList(String assetPath) async {
    final data = await loadJson(assetPath);
    if (data is List) return data;
    return const [];
  }

  static Future<Map<String, dynamic>> loadMap(String assetPath) async {
    final data = await loadJson(assetPath);
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }
}
