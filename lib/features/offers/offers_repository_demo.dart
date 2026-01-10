import 'package:my_amana_app/core/local/json_asset_loader.dart';

import 'models/offer.dart';
import 'offers_repository.dart';

class OffersRepositoryDemo implements OffersRepository {
  static const String _assetPath = 'assets/data/offers_ma.json';

  List<Offer>? _cache;

  @override
  Future<List<Offer>> fetchOffers() async {
    if (_cache != null) return _cache!;
    final rawList = await JsonAssetLoader.loadList(_assetPath);
    final offers = <Offer>[];
    for (final item in rawList) {
      if (item is Map) {
        final map = Map<String, dynamic>.from(item as Map);
        final offer = Offer.fromMap(map);
        if (offer != null) offers.add(offer);
      }
    }
    // Sort by startsAt desc (recent first)
    final epoch = DateTime.fromMillisecondsSinceEpoch(0);
    offers.sort((a, b) => (b.startsAt ?? epoch).compareTo(a.startsAt ?? epoch));
    _cache = offers;
    return offers;
  }
}
