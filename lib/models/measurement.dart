import 'package:binah_flutter_sdk/session/session.dart';
import 'package:binah_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/stress_level.dart';
import 'package:binah_poc/models/binah_session.dart';
import 'package:binah_poc/models/rppg_session.dart';
import 'package:binah_poc/models/session_info_listener.dart';
import 'package:binah_poc/models/vital_sign/heart_rate.dart';
import 'package:binah_poc/models/vital_sign/respiration_rate.dart';
import 'package:binah_poc/models/vital_sign/spo2.dart';
import 'package:binah_poc/models/vital_sign/stress_index.dart';
import 'package:binah_poc/models/vital_sign/stress_level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'binah_vital_sign_listener.dart';
import 'image_data_listener.dart';
import 'license/license_details.dart';

part 'measurement.g.dart';

@riverpod
class Measurement extends _$Measurement {
  Measurement();
  @override
  Session? build() => null;

  Future<Session> buildState() async {
    return await FaceSessionBuilder()
        .withSessionInfoListener(BinahSessionListener(ref))
        .withImageDataListener(BinahImageListener(ref))
        .withVitalSignsListener(BinahVitalSignListener(ref))
        .build(ref.read(licenseDetailsProvider));
  }

  Future<void> startOrStop() async {
    final sessionState = ref.read(binahSessionProvider);
    if (sessionState == SessionState.processing ||
        sessionState == SessionState.starting) {
      stop();
    } else {
      start();
    }
  }

  void start() async {
    clear();
    state ??= await ref.read(createSessionProvider.future);
    await Future.delayed(const Duration(seconds: 1));
    final sstate = ref.read(binahSessionProvider);
    if (sstate == SessionState.ready) {
      state?.start(60);
    }
  }

  void clear() {
    ref.read(respirationRateProvider.notifier).update(0);
    ref.read(heartRateProvider.notifier).update(0);
    ref.read(stressProvider.notifier).update(StressLevel.unknown);
    ref.read(spo2Provider.notifier).update(0);
    ref.read(stressIndexProvider.notifier).update(0);
  }

  void removeSession() {
    state = null;
  }

  void stop() async {
    state?.terminate();
    state = null;
  }
}
