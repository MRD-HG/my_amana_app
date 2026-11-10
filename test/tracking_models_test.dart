import 'package:flutter_test/flutter_test.dart';
import 'package:my_amana_app/features/tracking/models/tracking_models.dart';

void main() {
  group('trackingStageFromString', () {
    test('parses camelCase keys from the JSON assets', () {
      expect(trackingStageFromString('inTransit'), TrackingStage.inTransit);
      expect(trackingStageFromString('outForDelivery'), TrackingStage.outForDelivery);
    });

    test('parses snake_case keys written by trackingStageKey (round-trip)', () {
      for (final stage in TrackingStage.values) {
        expect(trackingStageFromString(trackingStageKey(stage)), stage);
      }
    });

    test('parses French labels used by the facteur screen', () {
      expect(trackingStageFromString('Colis accepté'), TrackingStage.accepted);
      expect(trackingStageFromString('En transit'), TrackingStage.inTransit);
      expect(trackingStageFromString('En cours de livraison'), TrackingStage.outForDelivery);
      expect(trackingStageFromString('Livré'), TrackingStage.delivered);
    });
  });

  test('latestEvent does not throw on an empty timeline', () {
    final info = TrackingInfo(
      id: 'X',
      weightKg: 0,
      codAmount: 0,
      service: 'Amana',
      events: const [],
    );
    expect(info.latestEvent.stage, TrackingStage.accepted);
  });
}
