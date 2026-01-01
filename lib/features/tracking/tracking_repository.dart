import 'tracking_models.dart';

class TrackingRepository {
  const TrackingRepository();

  static final Map<String, TrackingInfo> _mockData = {
    'AMN123456': TrackingInfo(
      id: 'AMN123456',
      weightKg: 2.4,
      codAmount: 0,
      service: 'Livraison a domicile',
      events: [
        TrackingEvent(
          stage: TrackingStage.delivered,
          description: 'Livre',
          location: 'Casablanca',
          timestamp: DateTime(2024, 11, 3, 12, 10),
        ),
        TrackingEvent(
          stage: TrackingStage.outForDelivery,
          description: 'En cours de livraison',
          location: 'Casablanca',
          timestamp: DateTime(2024, 11, 3, 8, 45),
        ),
        TrackingEvent(
          stage: TrackingStage.inTransit,
          description: 'En transit',
          location: 'Casablanca',
          timestamp: DateTime(2024, 11, 2, 14, 10),
        ),
        TrackingEvent(
          stage: TrackingStage.accepted,
          description: 'Colis accepte',
          location: 'Rabat',
          timestamp: DateTime(2024, 11, 2, 9, 20),
        ),
      ],
    ),
    'AMN654321': TrackingInfo(
      id: 'AMN654321',
      weightKg: 0.8,
      codAmount: 25,
      service: 'Retrait en agence',
      events: [
        TrackingEvent(
          stage: TrackingStage.inTransit,
          description: 'En transit',
          location: 'Fes',
          timestamp: DateTime(2024, 10, 28, 16, 30),
        ),
        TrackingEvent(
          stage: TrackingStage.accepted,
          description: 'Colis accepte',
          location: 'Meknes',
          timestamp: DateTime(2024, 10, 28, 9, 15),
        ),
      ],
    ),
  };

  Future<TrackingInfo?> fetchTracking(String trackingId) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final key = trackingId.trim().toUpperCase();
    return _mockData[key];
  }
}
