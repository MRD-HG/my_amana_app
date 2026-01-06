import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/pre_shipment.dart';
import 'pre_shipment_repository.dart';

class PreShipmentRepositoryFirestore implements PreShipmentRepository {
  PreShipmentRepositoryFirestore({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _createdBy => _auth.currentUser?.uid ?? 'anonymous';

  @override
  Future<PreShipment> createPreShipment({
    required String senderName,
    required String senderCity,
    required String receiverName,
    required String receiverCity,
    required String serviceType,
    required double weightKg,
  }) async {
    final doc = _firestore.collection('pre_shipments').doc();
    final now = DateTime.now();
    await doc.set({
      'senderName': senderName,
      'senderCity': senderCity,
      'receiverName': receiverName,
      'receiverCity': receiverCity,
      'serviceType': serviceType,
      'weightKg': weightKg,
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': _createdBy,
    });

    return PreShipment(
      id: doc.id,
      senderName: senderName,
      senderCity: senderCity,
      receiverName: receiverName,
      receiverCity: receiverCity,
      serviceType: serviceType,
      weightKg: weightKg,
      createdAt: now,
    );
  }
}
