import 'package:binah_flutter_sdk/session/session.dart';
import 'package:binah_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:binah_flutter_sdk/vital_signs/vitals/stress_level.dart';
import 'package:binah_poc/listeners/vital_sign_listener.dart';
import 'package:binah_poc/listeners/image_data_listener.dart';
import 'package:binah_poc/listeners/session_info_listener.dart';
import 'package:binah_poc/models/binah_session.dart';
import 'package:binah_poc/models/image/image_data.dart';
import 'package:binah_poc/models/image/image_validity.dart';
import 'package:binah_poc/models/license/license_details.dart';
import 'package:binah_poc/models/vital_sign/heart_rate.dart';
import 'package:binah_poc/models/vital_sign/respiration_rate.dart';
import 'package:binah_poc/models/vital_sign/spo2.dart';
import 'package:binah_poc/models/vital_sign/stress_index.dart';
import 'package:binah_poc/models/vital_sign/stress_level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rppg_session.g.dart';

@riverpod
class RPpgSession extends _$RPpgSession {
  @override
  FutureOr<Session?> build() => null;

  Future<Session> createNewSession() async {
    return await FaceSessionBuilder()
        .withSessionInfoListener(BinahSessionListener(ref))
        .withImageDataListener(BinahImageListener(ref))
        .withVitalSignsListener(BinahVitalSignListener(ref))
        .build(ref.read(licenseDetailsProvider));
  }

  void start() async {
    if (state.value == null ||
        ref.read(binahSessionProvider) == SessionState.terminated ||
        ref.read(binahSessionProvider) == SessionState.terminating) {
      clearData();

      state = await AsyncValue.guard(createNewSession);
      if (!state.hasError && state.hasValue) {
        for (int i = 0; i < 10; i++) {
          if (ref.read(binahSessionProvider) == SessionState.ready) {
            state.value!.start(60);
            break;
          }
          Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
  }

  void clearData() {
    ref.read(respirationRateProvider.notifier).update(0);
    ref.read(heartRateProvider.notifier).update(0);
    ref.read(stressProvider.notifier).update(StressLevel.unknown);
    ref.read(spo2Provider.notifier).update(0);
    ref.read(stressIndexProvider.notifier).update(0);
    ref.read(binahImageDataProvider.notifier).update(null);
    ref.read(binahImageValidityProvider.notifier).update(99);
  }

  Future<void> stop() async {
    if (state.hasValue &&
        (ref.read(binahSessionProvider) != SessionState.terminated ||
            ref.read(binahSessionProvider) != SessionState.terminating)) {
      state.value!.terminate();
    }
  }
}
