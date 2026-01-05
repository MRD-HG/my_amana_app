class ContactMessage {
  ContactMessage({
    required this.name,
    required this.contact,
    required this.subject,
    required this.message,
    this.trackingId,
    this.deviceInfo,
  });

  final String name;
  final String contact;
  final String subject;
  final String message;
  final String? trackingId;
  final String? deviceInfo;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contact': contact,
      'subject': subject,
      'message': message,
      'trackingId': trackingId,
      'deviceInfo': deviceInfo,
    };
  }
}
