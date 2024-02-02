import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/stress_level.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignStressLevel extends VitalSign<StressLevel> {
  VitalSignStressLevel(StressLevel value)
      : super(VitalSignTypes.stressLevel, value);

  @override
  String toString() {
    return value.toString();
  }
}
