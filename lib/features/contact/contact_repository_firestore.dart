import 'package:cloud_firestore/cloud_firestore.dart';

import 'contact_models.dart';
import 'contact_repository.dart';

class ContactRepositoryFirestore implements ContactRepository {
  ContactRepositoryFirestore({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> submitMessage(ContactMessage message) async {
    await _firestore.collection('contact_messages').add({
      ...message.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
