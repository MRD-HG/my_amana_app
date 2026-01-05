import '../../features/agences/agencies_repository.dart';
import '../../features/agences/agencies_repository_demo.dart';
import '../../features/agences/agencies_repository_firestore.dart';
import '../../features/contact/contact_repository.dart';
import '../../features/contact/contact_repository_demo.dart';
import '../../features/contact/contact_repository_firestore.dart';
import '../../features/feedback/feedback_repository.dart';
import '../../features/feedback/feedback_repository_demo.dart';
import '../../features/feedback/feedback_repository_firestore.dart';
import '../../features/facteur/facteur_repository.dart';
import '../../features/facteur/facteur_repository_demo.dart';
import '../../features/facteur/facteur_repository_firestore.dart';
import '../../features/tracking/tracking_repository.dart';
import '../../features/tracking/tracking_repository_demo.dart';
import '../../features/tracking/tracking_repository_firestore.dart';
import '../firebase/firebase_bootstrap.dart';

class AppRepositories {
  static late final TrackingRepository tracking;
  static late final AgenciesRepository agencies;
  static late final ContactRepository contact;
  static late final FeedbackRepository feedback;
  static late final FacteurRepository facteur;

  static void configure() {
    if (FirebaseBootstrap.enabled) {
      tracking = TrackingRepositoryFirestore();
      agencies = AgenciesRepositoryFirestore();
      contact = ContactRepositoryFirestore();
      feedback = FeedbackRepositoryFirestore();
      facteur = FacteurRepositoryFirestore();
    } else {
      tracking = TrackingRepositoryDemo();
      agencies = AgenciesRepositoryDemo();
      contact = ContactRepositoryDemo();
      feedback = FeedbackRepositoryDemo();
      facteur = FacteurRepositoryDemo();
    }
  }
}
