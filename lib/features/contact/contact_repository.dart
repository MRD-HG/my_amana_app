import 'contact_models.dart';

abstract class ContactRepository {
  Future<void> submitMessage(ContactMessage message);
}
