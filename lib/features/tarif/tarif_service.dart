import 'dart:math';

enum TarifType {
  national,
  international,
  ecommerce,
}

class TarifService {
  double calculate({
    required TarifType type,
    required double weightKg,
    double? lengthCm,
    double? widthCm,
    double? heightCm,
    bool packaged = false,
  }) {
    final billableWeight = _billableWeight(
      weightKg: weightKg,
      lengthCm: lengthCm,
      widthCm: widthCm,
      heightCm: heightCm,
    );

    double base;
    double rate;
    switch (type) {
      case TarifType.national:
        base = 15;
        rate = 8;
        break;
      case TarifType.international:
        base = 50;
        rate = 25;
        break;
      case TarifType.ecommerce:
        base = 20;
        rate = 10;
        break;
    }

    var total = base + (rate * billableWeight);
    if (packaged) {
      total += 5;
    }
    return total;
  }

  double _billableWeight({
    required double weightKg,
    double? lengthCm,
    double? widthCm,
    double? heightCm,
  }) {
    if (lengthCm == null || widthCm == null || heightCm == null) {
      return weightKg;
    }
    final volumetricWeight = (lengthCm * widthCm * heightCm) / 5000;
    if (volumetricWeight <= 0) {
      return weightKg;
    }
    return max(weightKg, volumetricWeight);
  }
}
