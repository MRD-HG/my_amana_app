import 'package:my_amana_app/core/local/prefs_store.dart';

import 'models/pre_shipment.dart';
import 'pre_shipment_repository.dart';

class PreShipmentRepositoryDemo implements PreShipmentRepository {
  static const String _key = 'pre_shipments_v1';

  @override
  Future<PreShipment> createPreShipment({
    required String senderName,
    required String senderCity,
    required String receiverName,
    required String receiverCity,
    required String serviceType,
    required double weightKg,
  }) async {
    final now = DateTime.now().toUtc();
    final id = 'PS-${now.millisecondsSinceEpoch}';

    final pre = PreShipment(
      id: id,
      senderName: senderName,
      senderCity: senderCity,
      receiverName: receiverName,
      receiverCity: receiverCity,
      serviceType: serviceType,
      weightKg: weightKg,
      createdAt: now,
    );

    final record = <String, dynamic>{
      'id': pre.id,
      'senderName': pre.senderName,
      'senderCity': pre.senderCity,
      'receiverName': pre.receiverName,
      'receiverCity': pre.receiverCity,
      'serviceType': pre.serviceType,
      'weightKg': pre.weightKg,
      'createdAt': pre.createdAt.toIso8601String(),
    };

    final existing = await PrefsStore.readList(_key);
    existing.insert(0, record);
    await PrefsStore.writeList(_key, existing);

    return pre;
  }
}
