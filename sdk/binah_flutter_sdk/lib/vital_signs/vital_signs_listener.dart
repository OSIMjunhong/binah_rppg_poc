import 'package:binah_flutter_sdk/vital_signs/vitals/vital_sign.dart';
import 'package:binah_flutter_sdk/vital_signs/vital_signs_results.dart';

abstract class VitalSignsListener {
  void onVitalSign(VitalSign vitalSign);
  void onFinalResults(VitalSignsResults results);
}
