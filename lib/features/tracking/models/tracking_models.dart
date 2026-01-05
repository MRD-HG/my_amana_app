enum TrackingStage {
  accepted,
  inTransit,
  outForDelivery,
  delivered,
}

class TrackingEvent {
  const TrackingEvent({
    required this.stage,
    required this.description,
    required this.location,
    required this.timestamp,
  });

  final TrackingStage stage;
  final String description;
  final String location;
  final DateTime timestamp;

  factory TrackingEvent.fromMap(Map<String, dynamic> data) {
    return TrackingEvent(
      stage: trackingStageFromString(data['stage'] as String?),
      description: (data['description'] as String?)?.trim().isNotEmpty == true
          ? data['description'] as String
          : 'Mise a jour',
      location: (data['location'] as String?)?.trim().isNotEmpty == true
          ? data['location'] as String
          : '---',
      timestamp: _parseTimestamp(data['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'stage': trackingStageKey(stage),
      'description': description,
      'location': location,
      'timestamp': timestamp,
    };
  }
}

class TrackingInfo {
  TrackingInfo({
    required this.id,
    required this.weightKg,
    required this.codAmount,
    required this.service,
    required List<TrackingEvent> events,
  }) : events = List.unmodifiable(events);

  final String id;
  final double weightKg;
  final double codAmount;
  final String service;
  final List<TrackingEvent> events;

  TrackingEvent get latestEvent => events.first;
}

TrackingStage trackingStageFromString(String? value) {
  final normalized = value?.toLowerCase().replaceAll(' ', '') ?? '';
  switch (normalized) {
    case 'accepted':
    case 'accept':
    case 'colisaccepte':
    case 'accepte':
      return TrackingStage.accepted;
    case 'intransit':
    case 'transit':
    case 'entransit':
      return TrackingStage.inTransit;
    case 'outfordelivery':
    case 'livraison':
    case 'encoursdelivraison':
      return TrackingStage.outForDelivery;
    case 'delivered':
    case 'livre':
      return TrackingStage.delivered;
    default:
      return TrackingStage.accepted;
  }
}

String trackingStageKey(TrackingStage stage) {
  switch (stage) {
    case TrackingStage.accepted:
      return 'accepted';
    case TrackingStage.inTransit:
      return 'in_transit';
    case TrackingStage.outForDelivery:
      return 'out_for_delivery';
    case TrackingStage.delivered:
      return 'delivered';
  }
}

DateTime _parseTimestamp(dynamic value) {
  if (value is DateTime) {
    return value;
  }
  if (value is String) {
    final parsed = DateTime.tryParse(value);
    if (parsed != null) {
      return parsed;
    }
  }
  return DateTime.now();
}

String formatTrackingTimestamp(DateTime timestamp) {
  final day = timestamp.day.toString().padLeft(2, '0');
  final month = timestamp.month.toString().padLeft(2, '0');
  final year = timestamp.year.toString();
  final hour = timestamp.hour.toString().padLeft(2, '0');
  final minute = timestamp.minute.toString().padLeft(2, '0');
  return '$day/$month/$year $hour:$minute';
}
