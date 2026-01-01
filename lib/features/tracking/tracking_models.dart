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

String formatTrackingTimestamp(DateTime timestamp) {
  final day = timestamp.day.toString().padLeft(2, '0');
  final month = timestamp.month.toString().padLeft(2, '0');
  final year = timestamp.year.toString();
  final hour = timestamp.hour.toString().padLeft(2, '0');
  final minute = timestamp.minute.toString().padLeft(2, '0');
  return '$day/$month/$year $hour:$minute';
}
