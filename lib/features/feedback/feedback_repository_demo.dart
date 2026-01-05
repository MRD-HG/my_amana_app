import 'feedback_models.dart';
import 'feedback_repository.dart';

class FeedbackRepositoryDemo implements FeedbackRepository {
  @override
  Future<void> submitFeedback(FeedbackEntry entry) async {
    await Future.delayed(const Duration(milliseconds: 600));
  }
}
