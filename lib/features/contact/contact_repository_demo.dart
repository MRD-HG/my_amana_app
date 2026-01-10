import 'package:my_amana_app/core/local/prefs_store.dart';

import 'contact_models.dart';
import 'contact_repository.dart';

class ContactRepositoryDemo implements ContactRepository {
  static const String _key = 'contact_messages_v1';

  @override
  Future<void> submitMessage(ContactMessage message) async {
    final now = DateTime.now().toUtc();
    final record = <String, dynamic>{
      ...message.toMap(),
      'createdAt': now.toIso8601String(),
    };

    final existing = await PrefsStore.readList(_key);
    existing.insert(0, record);
    await PrefsStore.writeList(_key, existing);
  }
}
