import 'models/facteur_models.dart';

abstract class FacteurRepository {
  Stream<FacteurUser?> authStateChanges();

  Future<FacteurUser?> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<List<ShipmentSummary>> fetchAssignedShipments(FacteurUser user);

  Future<void> updateShipmentStatus({
    required String trackingId,
    required ShipmentEvent event,
    required String status,
  });
}
