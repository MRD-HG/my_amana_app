import 'pre_shipment_repository.dart';
import 'models/pre_shipment.dart';

class PreShipmentRepositoryDemo implements PreShipmentRepository {
  @override
  Future<PreShipment> createPreShipment({
    required String senderName,
    required String senderCity,
    required String receiverName,
    required String receiverCity,
    required String serviceType,
    required double weightKg,
  }) async {
    final id = 'PRE-${DateTime.now().millisecondsSinceEpoch}';
    return PreShipment(
      id: id,
      senderName: senderName,
      senderCity: senderCity,
      receiverName: receiverName,
      receiverCity: receiverCity,
      serviceType: serviceType,
      weightKg: weightKg,
      createdAt: DateTime.now(),
    );
  }
}
