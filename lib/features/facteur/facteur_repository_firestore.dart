import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'facteur_repository.dart';
import 'models/facteur_models.dart';

class FacteurRepositoryFirestore implements FacteurRepository {
  FacteurRepositoryFirestore({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<FacteurUser?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return null;
      }
      return _fetchUserProfile(user);
    });
  }

  @override
  Future<FacteurUser?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      return null;
    }
    return _fetchUserProfile(user);
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<List<ShipmentSummary>> fetchAssignedShipments(
    FacteurUser user,
  ) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('shipments')
        .where('assignedToUid', isEqualTo: user.uid);

    var snapshot = await query.get();

    if (snapshot.docs.isEmpty && user.agencyId != null) {
      snapshot = await _firestore
          .collection('shipments')
          .where('agencyId', isEqualTo: user.agencyId)
          .get();
    }

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ShipmentSummary(
        trackingId: _readString(data['trackingId']) ?? doc.id,
        status: _readString(data['status']) ?? 'En traitement',
        senderCity: _readString(data['senderCity']) ?? '---',
        receiverCity: _readString(data['receiverCity']) ?? '---',
        serviceType: _readString(data['serviceType']),
      );
    }).toList();
  }

  @override
  Future<void> updateShipmentStatus({
    required String trackingId,
    required ShipmentEvent event,
    required String status,
  }) async {
    final docRef = _firestore.collection('shipments').doc(trackingId);
    await docRef.update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await docRef.collection('events').add({
      ...event.toMap(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<FacteurUser> _fetchUserProfile(User user) async {
    final doc = await _firestore.collection('users').doc(user.uid).get();
    final data = doc.data() ?? {};
    return FacteurUser(
      uid: user.uid,
      email: user.email ?? '---',
      role: _readString(data['role']) ?? 'client',
      displayName: _readString(data['displayName']),
      agencyId: _readString(data['agencyId']),
    );
  }
}

String? _readString(dynamic value) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return null;
}
