class Agency {
  const Agency({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.lat,
    required this.lng,
    this.phone,
  });

  final String id;
  final String name;
  final String address;
  final String city;
  final String? phone;
  final double lat;
  final double lng;

  factory Agency.fromMap(String id, Map<String, dynamic> data) {
    return Agency(
      id: id,
      name: _readString(data['name']) ?? 'Agence',
      address: _readString(data['address']) ?? '---',
      city: _readString(data['city']) ?? '---',
      phone: _readString(data['phone']),
      lat: _readDouble(data['lat']) ?? 0,
      lng: _readDouble(data['lng']) ?? 0,
    );
  }
}

String? _readString(dynamic value) {
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return null;
}

double? _readDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value);
  }
  return null;
}
