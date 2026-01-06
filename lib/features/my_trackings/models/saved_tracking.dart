class SavedTracking {
  const SavedTracking({
    required this.id,
    required this.label,
    required this.isFavorite,
    required this.lastViewedAt,
  });

  final String id;
  final String label;
  final bool isFavorite;
  final DateTime lastViewedAt;

  SavedTracking copyWith({
    String? label,
    bool? isFavorite,
    DateTime? lastViewedAt,
  }) {
    return SavedTracking(
      id: id,
      label: label ?? this.label,
      isFavorite: isFavorite ?? this.isFavorite,
      lastViewedAt: lastViewedAt ?? this.lastViewedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'isFavorite': isFavorite,
        'lastViewedAt': lastViewedAt.toIso8601String(),
      };

  static SavedTracking fromJson(Map<String, dynamic> json) {
    final rawDate = json['lastViewedAt'];
    DateTime dt;
    try {
      dt = DateTime.parse(rawDate?.toString() ?? '');
    } catch (_) {
      dt = DateTime.now();
    }
    return SavedTracking(
      id: (json['id'] ?? '').toString(),
      label: (json['label'] ?? '').toString(),
      isFavorite: json['isFavorite'] == true,
      lastViewedAt: dt,
    );
  }
}
