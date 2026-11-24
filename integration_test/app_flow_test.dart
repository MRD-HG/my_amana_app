// End-to-end smoke test: launches the real app on a device/emulator and walks
// through every main flow. Any crash, exception or layout overflow fails it.
//
// Run locally (emulator or phone connected):
//   flutter drive --driver=test_driver/integration_test.dart \
//     --target=integration_test/app_flow_test.dart
// Screenshots are written to ./screenshots/.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_amana_app/View/resultat.dart';
import 'package:my_amana_app/features/facteur/models/facteur_models.dart';
import 'package:my_amana_app/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

const _demoTracking = 'AMNMA240001';
const _facteurEmail = 'facteur.rabat@amana.ma';
const _facteurPassword = '123456';

/// Side-menu entries that open a new page.
const _drawerPages = [
  'Produit',
  'Mediatheque',
  'Suivi clientele',
  'Mes trackings',
  'Délais de livraison',
  'Promotions & actualités',
  'Pré-expédition (QR)',
  'Support / Réclamation',
  'Numeros utiles',
  'Produit prohibes',
  'FAQ',
  'Feedback',
  'Guide de bonnes pratiques',
];

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ---------------------------------------------------------------- helpers
  // The app has endless animations (splash spinner, loaders), so
  // pumpAndSettle would time out: pump in small steps instead.
  Future<void> pumpFor(WidgetTester tester, Duration duration) async {
    final end = DateTime.now().add(duration);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pumpUntil(
    WidgetTester tester,
    Finder finder, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await tester.pump(const Duration(milliseconds: 100));
      if (finder.evaluate().isNotEmpty) return;
    }
    // Help debugging: list what is actually on screen.
    final visible = find
        .byType(Text)
        .hitTestable()
        .evaluate()
        .map((e) => (e.widget as Text).data ?? '')
        .where((t) => t.trim().isNotEmpty)
        .take(40)
        .join(' | ');
    throw TestFailure(
        'Timed out after $timeout waiting for: $finder\nOn screen: $visible');
  }

  var surfaceConverted = false;
  Future<void> screenshot(WidgetTester tester, String name) async {
    // Best effort: a failed screenshot must not fail the functional test.
    try {
      if (Platform.isAndroid && !surfaceConverted) {
        await binding.convertFlutterSurfaceToImage();
        surfaceConverted = true;
      }
      await pumpFor(tester, const Duration(milliseconds: 600));
      await binding.takeScreenshot(name).timeout(const Duration(seconds: 30));
    } catch (e) {
      debugPrint('Screenshot "$name" skipped: $e');
    }
  }

  // Fill a field through its controller: avoids opening the on-screen
  // keyboard, whose animations crash headless CI emulators.
  Future<void> setText(WidgetTester tester, Finder field, String text) async {
    final controller = tester.widget<TextField>(field).controller;
    if (controller == null) {
      throw TestFailure('TextField has no controller: $field');
    }
    controller.text = text;
    await tester.pump();
  }

  Future<void> popRoute(WidgetTester tester) async {
    tester.state<NavigatorState>(find.byType(Navigator).first).pop();
    await pumpFor(tester, const Duration(milliseconds: 800));
  }

  Future<void> openDrawer(WidgetTester tester) async {
    tester.state<ScaffoldState>(find.byType(Scaffold).first).openDrawer();
    await pumpFor(tester, const Duration(milliseconds: 800));
  }

  Future<void> tapDrawerItem(WidgetTester tester, String label) async {
    final item = find.descendant(
      of: find.byType(Drawer),
      matching: find.text(label),
    );
    await tester.scrollUntilVisible(
      item,
      120,
      scrollable: find
          .descendant(of: find.byType(Drawer), matching: find.byType(Scrollable))
          .first,
    );
    await tester.tap(item);
    await pumpFor(tester, const Duration(seconds: 2));
  }

  Future<void> tapTab(WidgetTester tester, String label) async {
    await tester.tap(find.descendant(
      of: find.byType(BottomNavigationBar),
      matching: find.text(label),
    ));
    await pumpFor(tester, const Duration(seconds: 1));
  }

  Future<void> trackParcel(WidgetTester tester, String code) async {
    final field = find.widgetWithText(TextField, 'Scanner ou saisissez');
    await pumpUntil(tester, field);
    await setText(tester, field, code);
    // Same callback the keyboard "search" key triggers. Called directly so
    // the test doesn't depend on the emulator's keyboard connection state.
    tester.widget<TextField>(field).onSubmitted!(code);
    await pumpUntil(tester, find.byType(Resultat));
    await pumpFor(tester, const Duration(seconds: 1));
  }

  // ------------------------------------------------------------------ test
  testWidgets('full app journey: client + facteur', (tester) async {
    // Fresh state so onboarding is shown, as on a first install.
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    app.main();

    // 1. Splash -> space chooser
    await pumpUntil(tester, find.text('Bienvenue sur My Amana'));
    await screenshot(tester, '01_choose_space');

    // 2. Client onboarding
    await tester.tap(find.text('Client'));
    await pumpUntil(tester, find.text('Suivez vos envois en temps reel.'));
    await screenshot(tester, '02_onboarding_tracking');
    await tester.tap(find.text('Continuer'));
    await pumpUntil(tester, find.text('Trouvez l agence Amana la plus proche.'));
    await pumpFor(tester, const Duration(milliseconds: 800)); // route transition
    await tester.tap(find.text('Continuer'));
    await pumpUntil(tester, find.text('Allons-y'));
    await screenshot(tester, '02b_onboarding_tariff');
    await tester.tap(find.text('Allons-y'));

    // 3. Home
    await pumpUntil(tester, find.byType(BottomNavigationBar));
    await pumpFor(tester, const Duration(seconds: 2));
    await screenshot(tester, '03_home');

    // 4. Tracking: known code shows its timeline, unknown code says so
    await trackParcel(tester, _demoTracking);
    await pumpUntil(tester, find.text(_demoTracking));
    await screenshot(tester, '04_tracking_result');
    await popRoute(tester);

    await trackParcel(tester, 'AMNMA999999');
    await pumpUntil(tester, find.text('Aucun resultat pour ce numero de suivi.'));
    await popRoute(tester);

    // 5. Bottom tabs
    await tapTab(tester, 'Agences');
    final agencySearch =
        find.widgetWithText(TextField, 'Rechercher une agence').hitTestable();
    await pumpUntil(tester, agencySearch);
    await setText(tester, agencySearch, 'Rabat');
    await pumpFor(tester, const Duration(seconds: 2));
    await screenshot(tester, '05_agencies');

    await tapTab(tester, 'Tarif');
    final weight = find.widgetWithText(TextField, 'Poids (kg)').hitTestable();
    await pumpUntil(tester, weight);
    await setText(tester, weight.first, '2');
    await tester.tap(find.text('Calculer').hitTestable().first);
    // national: 15 + 8 * 2 kg = 31 DH
    await pumpUntil(tester, find.text('Tarif estime: 31.00 DH'));
    await screenshot(tester, '06_tariff');

    await tapTab(tester, 'Contact');
    await pumpUntil(
        tester, find.widgetWithText(TextField, 'Nom et prenom').hitTestable());
    await screenshot(tester, '07_contact');

    await tapTab(tester, 'Suivi');
    await pumpFor(tester, const Duration(seconds: 1));

    // 6. Every side-menu page opens without error
    await openDrawer(tester);
    await screenshot(tester, '08_side_menu');
    tester.state<ScaffoldState>(find.byType(Scaffold).first).closeDrawer();
    await pumpFor(tester, const Duration(milliseconds: 800));

    for (final label in _drawerPages) {
      await openDrawer(tester);
      await tapDrawerItem(tester, label);
      expect(find.byType(Drawer).hitTestable(), findsNothing,
          reason: '"$label" should open a new page');
      if (label == 'Mes trackings' || label == 'Promotions & actualités') {
        await screenshot(tester, '09_${label.split(' ').first.toLowerCase()}');
      }
      await popRoute(tester);
    }

    // 7. Facteur: login, update a parcel status, logout
    await openDrawer(tester);
    await tapDrawerItem(tester, 'Espace facteur');
    await pumpUntil(tester, find.text('Se connecter'));
    await screenshot(tester, '10_facteur_login');

    await setText(
        tester, find.widgetWithText(TextField, 'Votre email'), _facteurEmail);
    await setText(tester, find.widgetWithText(TextField, 'Votre mot de passe'),
        _facteurPassword);
    await tester.tap(find.text('Se connecter'));
    await pumpUntil(tester, find.text('Gerez rapidement vos livraisons du jour.'));
    await pumpUntil(tester, find.text('Mettre a jour'));

    final shipmentField = tester.widget<DropdownButtonFormField<ShipmentSummary>>(
      find.byType(DropdownButtonFormField<ShipmentSummary>),
    );
    final updatedId = shipmentField.initialValue!.trackingId;

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await pumpFor(tester, const Duration(seconds: 1));
    await tester.tap(find.text('Livre').last);
    await pumpFor(tester, const Duration(seconds: 1));

    await tester.ensureVisible(find.text('Mettre a jour'));
    await tester.tap(find.text('Mettre a jour'));
    await pumpUntil(tester, find.text('Statut mis a jour.'));
    await screenshot(tester, '11_facteur_dashboard');

    await tester.tap(find.byIcon(Icons.logout));
    await pumpUntil(tester, find.text('Se connecter'));
    await popRoute(tester);

    // 8. The client now sees the facteur's update on the timeline
    await trackParcel(tester, updatedId);
    await pumpUntil(tester, find.textContaining('Livre -'));
    await screenshot(tester, '12_tracking_after_update');
    await popRoute(tester);
  });
}
