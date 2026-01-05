import '../../tracking/models/tracking_models.dart';

class FacteurUser {
  const FacteurUser({
    required this.uid,
    required this.email,
    required this.role,
    this.displayName,
    this.agencyId,
  });

  final String uid;
  final String email;
  final String role;
  final String? displayName;
  final String? agencyId;

  bool get isAuthorized => role == 'facteur';
}

class ShipmentSummary {
  const ShipmentSummary({
    required this.trackingId,
    required this.status,
    required this.senderCity,
    required this.receiverCity,
    this.serviceType,
  });

  final String trackingId;
  final String status;
  final String senderCity;
  final String receiverCity;
  final String? serviceType;
}

class ShipmentEvent {
  const ShipmentEvent({
    required this.stage,
    required this.description,
    required this.location,
    required this.timestamp,
  });

  final TrackingStage stage;
  final String description;
  final String location;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return {
      'stage': trackingStageKey(stage),
      'description': description,
      'location': location,
      'timestamp': timestamp,
    };
  }
}
