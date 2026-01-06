class PreShipment {
  const PreShipment({
    required this.id,
    required this.senderName,
    required this.senderCity,
    required this.receiverName,
    required this.receiverCity,
    required this.serviceType,
    required this.weightKg,
    required this.createdAt,
  });

  final String id;
  final String senderName;
  final String senderCity;
  final String receiverName;
  final String receiverCity;
  final String serviceType;
  final double weightKg;
  final DateTime createdAt;

  Map<String, dynamic> toFirestore(String createdBy) => {
        'senderName': senderName,
        'senderCity': senderCity,
        'receiverName': receiverName,
        'receiverCity': receiverCity,
        'serviceType': serviceType,
        'weightKg': weightKg,
        'createdAt': createdAt,
        'createdBy': createdBy,
      };
}
