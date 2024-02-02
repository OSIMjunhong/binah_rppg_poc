import 'package:binah_flutter_sdk/vital_signs/vital_sign_confidence.dart';
import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignRespirationRate extends VitalSign<int> {
  final VitalSignConfidence? confidence;

  VitalSignRespirationRate(int value, {this.confidence})
      : super(VitalSignTypes.respirationRate, value);

  @override
  String toString() {
    return value.toString();
  }
}
