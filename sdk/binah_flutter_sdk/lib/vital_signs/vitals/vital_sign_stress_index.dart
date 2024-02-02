import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignStressIndex extends VitalSign<int> {
  VitalSignStressIndex(int value) : super(VitalSignTypes.stressIndex, value);

  @override
  String toString() {
    return value.toString();
  }
}
