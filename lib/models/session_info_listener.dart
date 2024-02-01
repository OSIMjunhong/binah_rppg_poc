import 'package:binah_flutter_sdk/alerts/error_data.dart';
import 'package:binah_flutter_sdk/alerts/warning_data.dart';
import 'package:binah_flutter_sdk/license/license_info.dart';
import 'package:binah_flutter_sdk/session/session_enabled_vital_signs.dart';
import 'package:binah_flutter_sdk/session/session_info_listener.dart';
import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:binah_poc/models/binah_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class BinahSessionListener implements SessionInfoListener {
  final Ref _ref;

  BinahSessionListener(this._ref);
  @override
  void onEnabledVitalSigns(SessionEnabledVitalSigns enabledVitalSigns) {}

  @override
  void onError(ErrorData errorData) =>
      print('error code : ${errorData.code}, domain: ${errorData.domain}');

  @override
  void onLicenseInfo(LicenseInfo licenseInfo) {}

  @override
  void onSessionStateChange(SessionState sessionState) =>
      _ref.read(binahSessionProvider.notifier).update(sessionState);

  @override
  void onWarning(WarningData warningData) {}
}
