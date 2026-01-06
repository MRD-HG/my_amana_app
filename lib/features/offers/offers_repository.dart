import 'models/offer.dart';

abstract class OffersRepository {
  Future<List<Offer>> fetchOffers();
}
