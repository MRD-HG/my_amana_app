import 'support_repository.dart';
import 'models/support_ticket.dart';

class SupportRepositoryDemo implements SupportRepository {
  final List<SupportTicket> _tickets = [];

  @override
  Future<void> createTicket({
    required String category,
    required String message,
    String? trackingId,
  }) async {
    _tickets.insert(
      0,
      SupportTicket(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        category: category,
        message: message,
        status: 'open',
        trackingId: trackingId,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<List<SupportTicket>> fetchMyTickets() async {
    return List.unmodifiable(_tickets);
  }
}
