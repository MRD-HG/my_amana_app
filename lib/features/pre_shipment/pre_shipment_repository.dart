import 'models/pre_shipment.dart';

abstract class PreShipmentRepository {
  Future<PreShipment> createPreShipment({
    required String senderName,
    required String senderCity,
    required String receiverName,
    required String receiverCity,
    required String serviceType,
    required double weightKg,
  });
}
