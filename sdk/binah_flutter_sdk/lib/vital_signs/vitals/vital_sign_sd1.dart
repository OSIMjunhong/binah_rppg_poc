import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignSd1 extends VitalSign<int> {
  VitalSignSd1(int value) : super(VitalSignTypes.sd1, value);

  @override
  String toString() {
    return value.toString();
  }
}
