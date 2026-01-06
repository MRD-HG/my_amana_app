import 'offers_repository.dart';
import 'models/offer.dart';

class OffersRepositoryDemo implements OffersRepository {
  @override
  Future<List<Offer>> fetchOffers() async {
    return [
      Offer(
        id: 'demo_1',
        title: 'Offre e-commerce',
        summary: 'Solutions de livraison pour vos clients partout au Maroc.',
        imageUrl: '',
        linkUrl: '',
        startsAt: DateTime.now().subtract(const Duration(days: 2)),
        endsAt: DateTime.now().add(const Duration(days: 20)),
      ),
      Offer(
        id: 'demo_2',
        title: 'Livraison Express',
        summary: 'Délais optimisés avec suivi amélioré.',
        imageUrl: '',
        linkUrl: '',
        startsAt: DateTime.now().subtract(const Duration(days: 10)),
        endsAt: null,
      ),
    ];
  }
}
