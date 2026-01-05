import 'agencies_repository.dart';
import 'models/agency.dart';

class AgenciesRepositoryDemo implements AgenciesRepository {
  static const List<Agency> _agencies = [
    Agency(
      id: 'rabat-centre',
      name: 'Agence Rabat Centre',
      address: 'Avenue Mohammed V',
      city: 'Rabat',
      phone: '0537 00 00 00',
      lat: 34.0209,
      lng: -6.8416,
    ),
    Agency(
      id: 'casablanca-maarif',
      name: 'Agence Casablanca Maarif',
      address: 'Boulevard Bir Anzarane',
      city: 'Casablanca',
      phone: '0522 00 00 00',
      lat: 33.5899,
      lng: -7.6164,
    ),
    Agency(
      id: 'marrakech-gueliz',
      name: 'Agence Marrakech Gueliz',
      address: 'Rue Abdelkrim Khattabi',
      city: 'Marrakech',
      phone: '0524 00 00 00',
      lat: 31.6387,
      lng: -8.0105,
    ),
    Agency(
      id: 'tanger-port',
      name: 'Agence Tanger Port',
      address: 'Avenue Hassan II',
      city: 'Tanger',
      phone: '0539 00 00 00',
      lat: 35.7765,
      lng: -5.8063,
    ),
    Agency(
      id: 'fes-centre',
      name: 'Agence Fes Centre',
      address: 'Boulevard Allal Ben Abdellah',
      city: 'Fes',
      phone: '0535 00 00 00',
      lat: 34.0356,
      lng: -5.0026,
    ),
  ];

  @override
  Future<List<Agency>> fetchAgencies({String? query}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final normalized = query?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return _agencies;
    }
    return _agencies.where((agency) {
      return agency.name.toLowerCase().contains(normalized) ||
          agency.city.toLowerCase().contains(normalized) ||
          agency.address.toLowerCase().contains(normalized);
    }).toList();
  }
}
