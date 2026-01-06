class Offer {
  const Offer({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.linkUrl,
    required this.startsAt,
    required this.endsAt,
  });

  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final String linkUrl;
  final DateTime? startsAt;
  final DateTime? endsAt;

  Map<String, dynamic> toJson() => {
        'title': title,
        'summary': summary,
        'imageUrl': imageUrl,
        'linkUrl': linkUrl,
        'startsAt': startsAt?.toIso8601String(),
        'endsAt': endsAt?.toIso8601String(),
      };

  static Offer fromFirestore(String id, Map<String, dynamic> data) {
    DateTime? parse(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v;
      if (v is String) {
        try { return DateTime.parse(v); } catch (_) { return null; }
      }
      // Firestore Timestamp handled in repositories to keep model clean.
      return null;
    }

    return Offer(
      id: id,
      title: (data['title'] ?? '').toString(),
      summary: (data['summary'] ?? data['description'] ?? '').toString(),
      imageUrl: (data['imageUrl'] ?? '').toString(),
      linkUrl: (data['linkUrl'] ?? '').toString(),
      startsAt: parse(data['startsAt']),
      endsAt: parse(data['endsAt']),
    );
  }
}
