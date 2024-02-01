import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vital_signs_listener.dart';
import 'package:binah_flutter_sdk/vital_signs/vital_signs_results.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign_oxygen_saturation.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign_pulse_rate.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign_respiration_rate.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign_stress_index.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign_stress_level.dart';
import 'package:binah_poc/models/vital_sign/heart_rate.dart';
import 'package:binah_poc/models/vital_sign/respiration_rate.dart';
import 'package:binah_poc/models/vital_sign/spo2.dart';
import 'package:binah_poc/models/vital_sign/stress_index.dart';
import 'package:binah_poc/models/vital_sign/stress_level.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinahVitalSignListener implements VitalSignsListener {
  final Ref _ref;

  const BinahVitalSignListener(this._ref);

  @override
  void onFinalResults(VitalSignsResults results) {
    VitalSign? vitalSign = results.getResult(VitalSignTypes.oxygenSaturation);
    if (vitalSign != null && vitalSign is VitalSignOxygenSaturation) {
      _ref.read(spo2Provider.notifier).update(vitalSign.value);
    }
    vitalSign = results.getResult(VitalSignTypes.pulseRate);
    if (vitalSign != null && vitalSign is VitalSignPulseRate) {
      _ref.read(heartRateProvider.notifier).update(vitalSign.value);
    }
    vitalSign = results.getResult(VitalSignTypes.respirationRate);
    if (vitalSign != null && vitalSign is VitalSignRespirationRate) {
      _ref.read(respirationRateProvider.notifier).update(vitalSign.value);
    }
    vitalSign = results.getResult(VitalSignTypes.stressLevel);
    if (vitalSign != null && vitalSign is VitalSignStressLevel) {
      _ref.read(stressProvider.notifier).update(vitalSign.value);
    }
    vitalSign = results.getResult(VitalSignTypes.stressIndex);
    if (vitalSign != null && vitalSign is VitalSignStressIndex) {
      _ref.read(stressIndexProvider.notifier).update(vitalSign.value);
    }
  }

  @override
  void onVitalSign(VitalSign vitalSign) {
    switch (vitalSign.type) {
      case VitalSignTypes.pulseRate:
        _ref
            .read(heartRateProvider.notifier)
            .update((vitalSign as VitalSignPulseRate).value);
      case VitalSignTypes.oxygenSaturation:
        _ref
            .read(spo2Provider.notifier)
            .update((vitalSign as VitalSignOxygenSaturation).value);
      case VitalSignTypes.respirationRate:
        _ref
            .read(respirationRateProvider.notifier)
            .update((vitalSign as VitalSignRespirationRate).value);
    }
  }
}
