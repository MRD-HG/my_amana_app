import 'models/tracking_models.dart';

abstract class TrackingRepository {
  Future<TrackingInfo?> fetchTracking(String trackingId);
}
