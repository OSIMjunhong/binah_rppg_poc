import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignSd2 extends VitalSign<int> {
  VitalSignSd2(int value) : super(VitalSignTypes.sd2, value);

  @override
  String toString() {
    return value.toString();
  }
}
