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

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'displayName': displayName,
      'agencyId': agencyId,
    };
  }

  static FacteurUser fromMap(Map<String, dynamic> data) {
    return FacteurUser(
      uid: (data['uid'] ?? '').toString(),
      email: (data['email'] ?? '').toString(),
      role: (data['role'] ?? 'facteur').toString(),
      displayName: (data['displayName'] ?? '').toString().trim().isEmpty
          ? null
          : (data['displayName'] ?? '').toString(),
      agencyId: (data['agencyId'] ?? '').toString().trim().isEmpty
          ? null
          : (data['agencyId'] ?? '').toString(),
    );
  }
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
