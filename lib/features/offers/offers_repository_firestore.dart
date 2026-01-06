import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/offer.dart';
import 'offers_repository.dart';

class OffersRepositoryFirestore implements OffersRepository {
  OffersRepositoryFirestore({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<List<Offer>> fetchOffers() async {
    final query = await _firestore
        .collection('offers')
        .orderBy('startsAt', descending: true)
        .limit(50)
        .get();

    return query.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data());
      // Normalize timestamps
      data['startsAt'] = _readDateTime(data['startsAt']);
      data['endsAt'] = _readDateTime(data['endsAt']);
      return Offer.fromFirestore(doc.id, data);
    }).where((o) => o.title.trim().isNotEmpty).toList();
  }

  DateTime? _readDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is Timestamp) return value.toDate();
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
