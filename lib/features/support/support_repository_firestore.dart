import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/support_ticket.dart';
import 'support_repository.dart';

class SupportRepositoryFirestore implements SupportRepository {
  SupportRepositoryFirestore({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get _createdByKey => _auth.currentUser?.uid ?? 'anonymous';

  @override
  Future<void> createTicket({
    required String category,
    required String message,
    String? trackingId,
  }) async {
    final now = DateTime.now();
    final doc = _firestore.collection('support_tickets').doc();
    await doc.set({
      'category': category,
      'message': message,
      'status': 'open',
      'trackingId': trackingId?.trim().isEmpty == true ? null : trackingId?.trim(),
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': _createdByKey,
    });
  }

  @override
  Future<List<SupportTicket>> fetchMyTickets() async {
    final query = await _firestore
        .collection('support_tickets')
        .where('createdBy', isEqualTo: _createdByKey)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();

    return query.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      data['createdAt'] = _readDateTime(data['createdAt']);
      return SupportTicket.fromData(doc.id, data);
    }).toList();
  }

  DateTime _readDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try { return DateTime.parse(value); } catch (_) {}
    }
    return DateTime.now();
  }
}
