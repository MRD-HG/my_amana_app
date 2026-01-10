import 'package:my_amana_app/core/local/prefs_store.dart';

import 'models/support_ticket.dart';
import 'support_repository.dart';

class SupportRepositoryDemo implements SupportRepository {
  static const String _key = 'support_tickets_v1';

  @override
  Future<List<SupportTicket>> fetchMyTickets() async {
    final list = await PrefsStore.readList(_key);
    final out = <SupportTicket>[];
    for (final item in list) {
      final id = (item['id'] ?? '').toString();
      if (id.isEmpty) continue;
      out.add(SupportTicket.fromData(id, item));
    }
    // newest first
    out.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return out;
  }

  @override
  Future<void> createTicket({
    required String category,
    required String message,
    String? trackingId,
  }) async {
    final now = DateTime.now().toUtc();
    final id = now.millisecondsSinceEpoch.toString();

    final record = <String, dynamic>{
      'id': id,
      'category': category,
      'message': message,
      'status': 'open',
      'trackingId': trackingId,
      'createdAt': now.toIso8601String(),
    };

    final existing = await PrefsStore.readList(_key);
    existing.insert(0, record);
    await PrefsStore.writeList(_key, existing);
  }
}
