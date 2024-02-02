import 'package:binah_flutter_sdk/bridge/bridge_channels.dart';
import 'package:binah_flutter_sdk/bridge/method_calls.dart';
import 'package:flutter/services.dart';
import 'package:binah_flutter_sdk/session/session.dart';
import 'package:binah_flutter_sdk/session/session_builder/session_builder.dart';
import 'package:binah_flutter_sdk/health_monitor_exception.dart';
import 'package:binah_flutter_sdk/license/license_details.dart';
import 'package:binah_flutter_sdk/session/measurement_mode.dart';

@Deprecated('Will be removed in future versions of the SDK')
class FingerSessionBuilder extends SessionBuilder {
  @override
  Future<Session> build(LicenseDetails licenseDetails) async {
    var session = Session(
        sessionInfoListener: sessionInfoListener,
        vitalSignsListener: vitalSignListener,
        imageDataListener: imageDataListener);

    try {
      await methodChannel.invokeMethod(MethodCalls.createSession, {
        'measurementMode': MeasurementMode.finger.index,
        'licenseKey': licenseDetails.licenseKey,
        'productId': licenseDetails.productId,
        'options': options
      });
    } on PlatformException catch (e) {
      throw HealthMonitorException(e.message as String, int.parse(e.code));
    }

    return session;
  }
}
