import 'package:my_amana_app/core/storage/local_store.dart';

import 'models/saved_tracking.dart';

class MyTrackingsStore {
  MyTrackingsStore(this._store);

  static const String _key = 'my_trackings_v1';
  final LocalStore _store;

  static Future<MyTrackingsStore> create() async {
    final store = await LocalStore.instance();
    return MyTrackingsStore(store);
  }

  Future<List<SavedTracking>> loadAll() async {
    final items = _store.getJsonList(_key).map(SavedTracking.fromJson).toList();
    items.sort((a, b) {
      // Favorites first, then latest viewed.
      final fav = (b.isFavorite ? 1 : 0) - (a.isFavorite ? 1 : 0);
      if (fav != 0) return fav;
      return b.lastViewedAt.compareTo(a.lastViewedAt);
    });
    return items;
  }

  Future<void> saveViewed(String trackingId) async {
    final id = trackingId.trim().toUpperCase();
    if (id.isEmpty) return;

    final list = _store.getJsonList(_key);
    final existingIndex = list.indexWhere((e) => (e['id'] ?? '').toString().toUpperCase() == id);
    if (existingIndex >= 0) {
      final current = SavedTracking.fromJson(list[existingIndex]).copyWith(lastViewedAt: DateTime.now());
      list[existingIndex] = current.toJson();
    } else {
      list.insert(
        0,
        SavedTracking(
          id: id,
          label: id,
          isFavorite: false,
          lastViewedAt: DateTime.now(),
        ).toJson(),
      );
    }

    // keep last 50
    final trimmed = list.take(50).toList();
    await _store.setJsonList(_key, trimmed);
  }

  Future<void> toggleFavorite(String trackingId) async {
    final id = trackingId.trim().toUpperCase();
    final list = _store.getJsonList(_key);
    final idx = list.indexWhere((e) => (e['id'] ?? '').toString().toUpperCase() == id);
    if (idx < 0) return;
    final current = SavedTracking.fromJson(list[idx]);
    list[idx] = current.copyWith(isFavorite: !current.isFavorite).toJson();
    await _store.setJsonList(_key, list);
  }

  Future<void> rename(String trackingId, String newLabel) async {
    final id = trackingId.trim().toUpperCase();
    final label = newLabel.trim();
    if (label.isEmpty) return;

    final list = _store.getJsonList(_key);
    final idx = list.indexWhere((e) => (e['id'] ?? '').toString().toUpperCase() == id);
    if (idx < 0) return;
    final current = SavedTracking.fromJson(list[idx]);
    list[idx] = current.copyWith(label: label).toJson();
    await _store.setJsonList(_key, list);
  }

  Future<void> delete(String trackingId) async {
    final id = trackingId.trim().toUpperCase();
    final list = _store.getJsonList(_key);
    list.removeWhere((e) => (e['id'] ?? '').toString().toUpperCase() == id);
    await _store.setJsonList(_key, list);
  }
}
