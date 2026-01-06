import 'models/support_ticket.dart';

abstract class SupportRepository {
  Future<List<SupportTicket>> fetchMyTickets();
  Future<void> createTicket({
    required String category,
    required String message,
    String? trackingId,
  });
}
