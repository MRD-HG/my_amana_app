import 'dart:async';

import 'package:my_amana_app/core/local/json_asset_loader.dart';
import 'package:my_amana_app/core/local/prefs_store.dart';
import 'package:my_amana_app/features/tracking/models/tracking_models.dart';

import 'facteur_repository.dart';
import 'models/facteur_models.dart';

class FacteurRepositoryDemo implements FacteurRepository {
  FacteurRepositoryDemo() {
    _restoreSession();
  }

  static const String _usersAsset = 'assets/data/users_ma.json';
  static const String _shipmentsAsset = 'assets/data/shipments_ma.json';

  static const String _sessionKey = 'facteur_user_v1';
  static const String _updatesKey = 'shipment_updates_v1';

  final StreamController<FacteurUser?> _controller =
      StreamController<FacteurUser?>.broadcast();

  FacteurUser? _currentUser;

  Future<void> _restoreSession() async {
    final raw = await PrefsStore.readMap(_sessionKey);
    if (raw == null) {
      _controller.add(null);
      return;
    }
    final user = FacteurUser.fromMap(raw);
    _currentUser = user;
    _controller.add(user);
  }

  @override
  Stream<FacteurUser?> authStateChanges() => _controller.stream;

  @override
  Future<FacteurUser?> signIn({
    required String email,
    required String password,
  }) async {
    final e = email.trim().toLowerCase();
    final p = password.trim();

    if (e.isEmpty || p.isEmpty) return null;

    final rawList = await JsonAssetLoader.loadList(_usersAsset);
    for (final item in rawList) {
      if (item is Map) {
        final map = Map<String, dynamic>.from(item as Map);
        final itemEmail = (map['email'] ?? '').toString().trim().toLowerCase();
        final itemPass = (map['password'] ?? '').toString();
        if (itemEmail == e && itemPass == p) {
          final user = FacteurUser.fromMap(map);
          _currentUser = user;
          await PrefsStore.writeMap(_sessionKey, user.toMap());
          _controller.add(user);
          return user;
        }
      }
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    await PrefsStore.remove(_sessionKey);
    _controller.add(null);
  }

  Future<List<Map<String, dynamic>>> _loadShipments() async {
    final rawList = await JsonAssetLoader.loadList(_shipmentsAsset);
    final list = <Map<String, dynamic>>[];
    for (final item in rawList) {
      if (item is Map) list.add(Map<String, dynamic>.from(item as Map));
    }
    return list;
  }

  Future<Map<String, dynamic>> _readUpdates() async {
    final raw = await PrefsStore.readMap(_updatesKey);
    if (raw == null) return <String, dynamic>{};
    return raw;
  }

  String _statusFromStage(TrackingStage stage) {
    switch (stage) {
      case TrackingStage.accepted:
        return 'Accepted';
      case TrackingStage.inTransit:
        return 'In Transit';
      case TrackingStage.outForDelivery:
        return 'Out For Delivery';
      case TrackingStage.delivered:
        return 'Delivered';
    }
  }

  @override
  Future<List<ShipmentSummary>> fetchAssignedShipments(FacteurUser user) async {
    final shipments = await _loadShipments();
    final updates = await _readUpdates();

    final out = <ShipmentSummary>[];

    for (final s in shipments) {
      final assigned = (s['assignedToUid'] ?? '').toString().trim();
      if (assigned.isEmpty || assigned != user.uid) continue;

      final id = (s['id'] ?? '').toString();
      final senderCity = (s['senderCity'] ?? '---').toString();
      final receiverCity = (s['receiverCity'] ?? '---').toString();
      final serviceType = (s['serviceType'] ?? s['service'] ?? '').toString();

      // Base status (string)
      var status = (s['status'] ?? '').toString().trim();
      if (status.isEmpty) status = 'In Transit';

      // If there are local updates, derive status from latest event stage
      final upd = updates[id];
      if (upd is Map) {
        final rawEvents = upd['events'];
        if (rawEvents is List && rawEvents.isNotEmpty) {
          final last = rawEvents.first;
          if (last is Map) {
            final stage = trackingStageFromString((last['stage'] ?? '').toString());
            status = _statusFromStage(stage);
          }
        }
        if (upd['status'] != null) {
          final s2 = (upd['status'] ?? '').toString().trim();
          if (s2.isNotEmpty) status = s2;
        }
      }

      out.add(ShipmentSummary(
        trackingId: id,
        status: status,
        senderCity: senderCity,
        receiverCity: receiverCity,
        serviceType: serviceType.isEmpty ? null : serviceType,
      ));
    }

    return out;
  }

  @override
  Future<void> updateShipmentStatus({
    required String trackingId,
    required ShipmentEvent event,
    required String status,
  }) async {
    final id = trackingId.trim();
    if (id.isEmpty) return;

    final updates = await _readUpdates();
    final existing = updates[id];
    final record = existing is Map ? Map<String, dynamic>.from(existing) : <String, dynamic>{};

    final events = <Map<String, dynamic>>[];
    final oldEvents = record['events'];
    if (oldEvents is List) {
      for (final e in oldEvents) {
        if (e is Map) events.add(Map<String, dynamic>.from(e as Map));
      }
    }

    // Insert newest first
    events.insert(0, {
      'stage': trackingStageKey(event.stage),
      'description': event.description,
      'location': event.location,
      'timestamp': event.timestamp.toUtc().toIso8601String(),
    });

    record['events'] = events;
    record['status'] = status;

    updates[id] = record;
    await PrefsStore.writeMap(_updatesKey, updates);
  }
}
