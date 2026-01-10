import 'package:my_amana_app/core/local/json_asset_loader.dart';

import 'agencies_repository.dart';
import 'models/agency.dart';

class AgenciesRepositoryDemo implements AgenciesRepository {
  static const String _assetPath = 'assets/data/agencies_ma.json';

  List<Agency>? _cache;

  Future<List<Agency>> _loadAll() async {
    if (_cache != null) return _cache!;
    final rawList = await JsonAssetLoader.loadList(_assetPath);
    final agencies = <Agency>[];
    for (final item in rawList) {
      if (item is Map) {
        final map = Map<String, dynamic>.from(item as Map);
        final id = (map['id'] ?? '').toString().trim();
        if (id.isEmpty) continue;
        agencies.add(Agency.fromMap(id, map));
      }
    }
    _cache = agencies;
    return agencies;
  }

  @override
  Future<List<Agency>> fetchAgencies({String? query}) async {
    final all = await _loadAll();
    final q = (query ?? '').trim().toLowerCase();
    if (q.isEmpty) return all;

    return all.where((a) {
      return a.name.toLowerCase().contains(q) ||
          a.city.toLowerCase().contains(q) ||
          a.address.toLowerCase().contains(q);
    }).toList();
  }
}
