import 'package:my_amana_app/core/local/prefs_store.dart';

import 'feedback_models.dart';
import 'feedback_repository.dart';

class FeedbackRepositoryDemo implements FeedbackRepository {
  static const String _key = 'feedback_entries_v1';

  @override
  Future<void> submitFeedback(FeedbackEntry entry) async {
    final now = DateTime.now().toUtc();
    final record = <String, dynamic>{
      ...entry.toMap(),
      'createdAt': now.toIso8601String(),
    };

    final existing = await PrefsStore.readList(_key);
    existing.insert(0, record);
    await PrefsStore.writeList(_key, existing);
  }
}
