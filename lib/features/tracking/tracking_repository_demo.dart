import 'dart:convert';

import 'package:my_amana_app/core/local/json_asset_loader.dart';
import 'package:my_amana_app/core/local/prefs_store.dart';

import 'models/tracking_models.dart';
import 'tracking_repository.dart';

class TrackingRepositoryDemo implements TrackingRepository {
  static const String _assetPath = 'assets/data/shipments_ma.json';
  static const String _updatesKey = 'shipment_updates_v1';

  List<Map<String, dynamic>>? _baseCache;

  Future<List<Map<String, dynamic>>> _loadBase() async {
    if (_baseCache != null) return _baseCache!;
    final rawList = await JsonAssetLoader.loadList(_assetPath);
    final list = <Map<String, dynamic>>[];
    for (final item in rawList) {
      if (item is Map) {
        list.add(Map<String, dynamic>.from(item as Map));
      }
    }
    _baseCache = list;
    return list;
  }

  double _asDouble(dynamic v) {
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0;
    return 0;
  }

  TrackingInfo _fromMap(Map<String, dynamic> data) {
    final eventsRaw = data['events'];
    final events = <TrackingEvent>[];
    if (eventsRaw is List) {
      for (final e in eventsRaw) {
        if (e is Map) {
          events.add(TrackingEvent.fromMap(Map<String, dynamic>.from(e as Map)));
        }
      }
    }
    // Ensure latest first
    events.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return TrackingInfo(
      id: (data['id'] ?? '').toString(),
      weightKg: _asDouble(data['weightKg']),
      codAmount: _asDouble(data['codAmount']),
      service: (data['service'] ?? data['serviceType'] ?? 'Amana').toString(),
      events: events,
    );
  }

  Future<Map<String, dynamic>?> _readUpdateFor(String trackingId) async {
    final updates = await PrefsStore.readMap(_updatesKey);
    if (updates == null) return null;
    final raw = updates[trackingId];
    if (raw is Map) return Map<String, dynamic>.from(raw);
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return null;
  }

  List<TrackingEvent> _parseEvents(dynamic raw) {
    final out = <TrackingEvent>[];
    if (raw is List) {
      for (final e in raw) {
        if (e is Map) {
          out.add(TrackingEvent.fromMap(Map<String, dynamic>.from(e as Map)));
        }
      }
    }
    return out;
  }

  @override
  Future<TrackingInfo?> fetchTracking(String trackingId) async {
    final id = trackingId.trim();
    if (id.isEmpty) return null;

    final base = await _loadBase();
    Map<String, dynamic>? found;
    for (final item in base) {
      final itemId = (item['id'] ?? '').toString();
      if (itemId.toLowerCase() == id.toLowerCase()) {
        found = item;
        break;
      }
    }

    // Load local updates (status changes by facteur, etc.)
    final update = await _readUpdateFor(id);

    if (found == null && update == null) return null;

    final merged = <String, dynamic>{};
    if (found != null) merged.addAll(found);
    if (update != null) {
      // Merge events
      final baseEvents = _parseEvents(merged['events']);
      final newEvents = _parseEvents(update['events']);
      final allEvents = <TrackingEvent>[...baseEvents, ...newEvents];
      allEvents.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      merged['events'] = allEvents.map((e) => {
            'stage': trackingStageKey(e.stage),
            'description': e.description,
            'location': e.location,
            'timestamp': e.timestamp.toIso8601String(),
          }).toList();

      // Let update override status/service if provided
      if (update['service'] != null) merged['service'] = update['service'];
    }

    return _fromMap(merged);
  }
}
