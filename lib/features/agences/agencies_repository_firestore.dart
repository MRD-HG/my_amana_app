import 'package:cloud_firestore/cloud_firestore.dart';

import 'agencies_repository.dart';
import 'models/agency.dart';

class AgenciesRepositoryFirestore implements AgenciesRepository {
  AgenciesRepositoryFirestore({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<List<Agency>> fetchAgencies({String? query}) async {
    final snapshot = await _firestore.collection('agencies').get();
    final agencies = snapshot.docs
        .map((doc) => Agency.fromMap(doc.id, doc.data()))
        .toList();

    final normalized = query?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return agencies;
    }
    return agencies.where((agency) {
      return agency.name.toLowerCase().contains(normalized) ||
          agency.city.toLowerCase().contains(normalized) ||
          agency.address.toLowerCase().contains(normalized);
    }).toList();
  }
}
