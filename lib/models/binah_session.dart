import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'binah_session.g.dart';

@riverpod
class BinahSession extends _$BinahSession {
  @override
  SessionState build() => SessionState.initializing;

  void update(SessionState newState) {
    state = newState;
  }
}
