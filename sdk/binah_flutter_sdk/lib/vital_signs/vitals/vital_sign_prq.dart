import 'package:binah_flutter_sdk/vital_signs/vital_sign_confidence.dart';
import 'package:binah_flutter_sdk/vital_signs/vital_sign_types.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';

class VitalSignPrq extends VitalSign<double> {
  final VitalSignConfidence? confidence;

  VitalSignPrq(double value, {this.confidence})
      : super(VitalSignTypes.prq, value);

  @override
  String toString() {
    return value.toString();
  }
}
