import '../../features/agences/agencies_repository.dart';
import '../../features/agences/agencies_repository_demo.dart';
import '../../features/contact/contact_repository.dart';
import '../../features/contact/contact_repository_demo.dart';
import '../../features/feedback/feedback_repository.dart';
import '../../features/feedback/feedback_repository_demo.dart';
import '../../features/facteur/facteur_repository.dart';
import '../../features/facteur/facteur_repository_demo.dart';
import '../../features/offers/offers_repository.dart';
import '../../features/offers/offers_repository_demo.dart';
import '../../features/pre_shipment/pre_shipment_repository.dart';
import '../../features/pre_shipment/pre_shipment_repository_demo.dart';
import '../../features/support/support_repository.dart';
import '../../features/support/support_repository_demo.dart';
import '../../features/tracking/tracking_repository.dart';
import '../../features/tracking/tracking_repository_demo.dart';

/// Central place to access repositories.
///
/// Firebase has been removed. All repositories use local JSON assets + local storage.
class AppRepositories {
  AppRepositories._();

  static late final TrackingRepository tracking;
  static late final AgenciesRepository agencies;
  static late final ContactRepository contact;
  static late final FeedbackRepository feedback;
  static late final FacteurRepository facteur;
  static late final OffersRepository offers;
  static late final SupportRepository support;
  static late final PreShipmentRepository preShipment;

  static void configure() {
    tracking = TrackingRepositoryDemo();
    agencies = AgenciesRepositoryDemo();
    contact = ContactRepositoryDemo();
    feedback = FeedbackRepositoryDemo();
    facteur = FacteurRepositoryDemo();
    offers = OffersRepositoryDemo();
    support = SupportRepositoryDemo();
    preShipment = PreShipmentRepositoryDemo();
  }
}
