import 'dart:async';

import 'facteur_repository.dart';
import 'models/facteur_models.dart';

class FacteurRepositoryDemo implements FacteurRepository {
  FacteurRepositoryDemo() {
    _controller.add(_currentUser);
  }

  final StreamController<FacteurUser?> _controller =
      StreamController<FacteurUser?>.broadcast();

  FacteurUser? _currentUser;

  final List<ShipmentSummary> _shipments = [
    ShipmentSummary(
      trackingId: 'AMN123456',
      status: 'En cours de livraison',
      senderCity: 'Rabat',
      receiverCity: 'Casablanca',
      serviceType: 'Livraison a domicile',
    ),
    ShipmentSummary(
      trackingId: 'AMN654321',
      status: 'En transit',
      senderCity: 'Fes',
      receiverCity: 'Meknes',
      serviceType: 'Retrait en agence',
    ),
    ShipmentSummary(
      trackingId: 'AMN908070',
      status: 'Colis accepte',
      senderCity: 'Tanger',
      receiverCity: 'Rabat',
      serviceType: 'Express',
    ),
  ];

  @override
  Stream<FacteurUser?> authStateChanges() => _controller.stream;

  @override
  Future<FacteurUser?> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.trim().isEmpty || password.isEmpty) {
      return null;
    }
    _currentUser = FacteurUser(
      uid: 'demo_facteur',
      email: email.trim(),
      role: 'facteur',
      displayName: 'Facteur Demo',
      agencyId: 'rabat-centre',
    );
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(_currentUser);
  }

  @override
  Future<List<ShipmentSummary>> fetchAssignedShipments(FacteurUser user) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List<ShipmentSummary>.from(_shipments);
  }

  @override
  Future<void> updateShipmentStatus({
    required String trackingId,
    required ShipmentEvent event,
    required String status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _shipments.indexWhere(
      (shipment) => shipment.trackingId == trackingId,
    );
    if (index != -1) {
      final current = _shipments[index];
      _shipments[index] = ShipmentSummary(
        trackingId: current.trackingId,
        status: status,
        senderCity: current.senderCity,
        receiverCity: current.receiverCity,
        serviceType: current.serviceType,
      );
    }
  }
}
