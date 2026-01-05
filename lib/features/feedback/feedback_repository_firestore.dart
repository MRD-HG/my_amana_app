import 'package:cloud_firestore/cloud_firestore.dart';

import 'feedback_models.dart';
import 'feedback_repository.dart';

class FeedbackRepositoryFirestore implements FeedbackRepository {
  FeedbackRepositoryFirestore({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> submitFeedback(FeedbackEntry entry) async {
    await _firestore.collection('feedback').add({
      ...entry.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
