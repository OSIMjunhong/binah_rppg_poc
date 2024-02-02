import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignLfhf extends VitalSign<double> {
  VitalSignLfhf(double value) : super(VitalSignTypes.lfhf, value);

  @override
  String toString() {
    return value.toString();
  }
}
