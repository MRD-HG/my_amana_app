class SupportTicket {
  const SupportTicket({
    required this.id,
    required this.category,
    required this.message,
    required this.status,
    required this.trackingId,
    required this.createdAt,
  });

  final String id;
  final String category;
  final String message;
  final String status;
  final String? trackingId;
  final DateTime createdAt;

  Map<String, dynamic> toFirestore(String createdByKey) => {
        'category': category,
        'message': message,
        'status': status,
        'trackingId': trackingId,
        'createdAt': createdAt,
        'createdBy': createdByKey,
      };

  static SupportTicket fromData(String id, Map<String, dynamic> data) {
    DateTime dt;
    final raw = data['createdAt'];
    if (raw is DateTime) {
      dt = raw;
    } else if (raw is String) {
      try { dt = DateTime.parse(raw); } catch (_) { dt = DateTime.now(); }
    } else {
      dt = DateTime.now();
    }
    return SupportTicket(
      id: id,
      category: (data['category'] ?? 'Support').toString(),
      message: (data['message'] ?? '').toString(),
      status: (data['status'] ?? 'open').toString(),
      trackingId: (data['trackingId'] ?? '').toString().trim().isEmpty ? null : (data['trackingId'] ?? '').toString(),
      createdAt: dt,
    );
  }
}
