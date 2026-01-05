class FeedbackEntry {
  FeedbackEntry({
    required this.category,
    required this.message,
    this.rating,
    List<String>? tags,
  }) : tags = List.unmodifiable(tags ?? []);

  final String category;
  final int? rating;
  final List<String> tags;
  final String message;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'rating': rating,
      'tags': tags,
      'message': message,
    };
  }
}
