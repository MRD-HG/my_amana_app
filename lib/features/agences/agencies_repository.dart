import 'models/agency.dart';

abstract class AgenciesRepository {
  Future<List<Agency>> fetchAgencies({String? query});
}
