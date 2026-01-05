import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/tracking_models.dart';
import 'tracking_repository.dart';

class TrackingRepositoryFirestore implements TrackingRepository {
  TrackingRepositoryFirestore({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<TrackingInfo?> fetchTracking(String trackingId) async {
    final id = trackingId.trim().toUpperCase();
    final docRef = _firestore.collection('shipments').doc(id);
    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      return null;
    }
    final data = snapshot.data() ?? {};

    final eventsSnapshot = await docRef
        .collection('events')
        .orderBy('timestamp', descending: true)
        .get();

    final events = eventsSnapshot.docs
        .map((doc) => TrackingEvent.fromMap(_normalizeEvent(doc.data())))
        .toList();

    if (events.isEmpty) {
      final status = data['status'] as String? ?? 'En traitement';
      events.add(
        TrackingEvent(
          stage: trackingStageFromString(status),
          description: status,
          location: _readString(data['receiverCity']) ??
              _readString(data['senderCity']) ??
              '---',
          timestamp: _parseTimestamp(data['updatedAt']) ?? DateTime.now(),
        ),
      );
    }

    return TrackingInfo(
      id: _readString(data['trackingId']) ?? id,
      weightKg: _readDouble(data['weightKg']) ?? 0,
      codAmount: _readDouble(data['codAmount']) ?? 0,
      service: _readString(data['serviceType']) ??
          _readString(data['service']) ??
          'Service standard',
      events: events,
    );
  }

  Map<String, dynamic> _normalizeEvent(Map<String, dynamic> data) {
    return {
      'stage': data['stage'],
      'description': data['description'],
      'location': data['location'],
      'timestamp': _parseTimestamp(data['timestamp']) ?? DateTime.now(),
    };
  }

  DateTime? _parseTimestamp(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }
    if (value is DateTime) {
      return value;
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  double? _readDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  String? _readString(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return null;
  }
}
