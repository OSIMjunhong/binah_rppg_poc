import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignPnsIndex extends VitalSign<double> {
  VitalSignPnsIndex(double value) : super(VitalSignTypes.pnsIndex, value);

  @override
  String toString() {
    return value.toString();
  }
}
