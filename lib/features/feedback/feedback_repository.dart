import 'feedback_models.dart';

abstract class FeedbackRepository {
  Future<void> submitFeedback(FeedbackEntry entry);
}
