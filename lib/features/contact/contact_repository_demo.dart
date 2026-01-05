import 'contact_models.dart';
import 'contact_repository.dart';

class ContactRepositoryDemo implements ContactRepository {
  @override
  Future<void> submitMessage(ContactMessage message) async {
    await Future.delayed(const Duration(milliseconds: 600));
  }
}
