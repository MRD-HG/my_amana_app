import 'package:flutter_test/flutter_test.dart';
import 'package:my_amana_app/features/tarif/tarif_service.dart';

void main() {
  final service = TarifService();

  test('national tariff = base + rate * weight', () {
    expect(service.calculate(type: TarifType.national, weightKg: 2), 15 + 8 * 2);
  });

  test('packaging adds 5 MAD', () {
    expect(
      service.calculate(type: TarifType.ecommerce, weightKg: 1, packaged: true),
      20 + 10 * 1 + 5,
    );
  });

  test('volumetric weight is used when larger than real weight', () {
    // 50 x 40 x 30 / 5000 = 12 kg volumetric > 1 kg real
    expect(
      service.calculate(
        type: TarifType.international,
        weightKg: 1,
        lengthCm: 50,
        widthCm: 40,
        heightCm: 30,
      ),
      50 + 25 * 12,
    );
  });
}
