import 'package:binah_flutter_sdk/session/session.dart';
import 'package:binah_flutter_sdk/session/session_builder/face_session_builder.dart';
import 'package:binah_poc/listeners/vital_sign_listener.dart';
import 'package:binah_poc/listeners/image_data_listener.dart';
import 'package:binah_poc/listeners/session_info_listener.dart';
import 'package:binah_poc/models/license/license_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rppg_session.g.dart';

@riverpod
Future<Session> createSession(CreateSessionRef ref) async =>
    await FaceSessionBuilder()
        .withSessionInfoListener(BinahSessionListener(ref))
        .withImageDataListener(BinahImageListener(ref))
        .withVitalSignsListener(BinahVitalSignListener(ref))
        .build(ref.read(licenseDetailsProvider));
