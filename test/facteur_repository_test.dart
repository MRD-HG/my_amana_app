import 'package:flutter_test/flutter_test.dart';
import 'package:my_amana_app/features/facteur/facteur_repository_demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('late subscribers still receive the current session (regression)', () async {
    final repo = FacteurRepositoryDemo();
    // Simulate the splash delay: subscribe well after the session was restored.
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(await repo.authStateChanges().first, isNull);
  });

  test('sign in with demo credentials, then sign out', () async {
    final repo = FacteurRepositoryDemo();
    final user = await repo.signIn(email: 'facteur.rabat@amana.ma', password: '123456');
    expect(user?.isAuthorized, isTrue);
    expect((await repo.authStateChanges().first)?.uid, 'facteur-rabat-1');

    await repo.signOut();
    expect(await repo.authStateChanges().first, isNull);
  });

  test('wrong password is rejected', () async {
    final repo = FacteurRepositoryDemo();
    expect(await repo.signIn(email: 'facteur.rabat@amana.ma', password: 'x'), isNull);
  });
}
