import 'package:binah_flutter_sdk/alerts/error_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error.g.dart';

@riverpod
class RPpgError extends _$RPpgError {
  @override
  ErrorData? build() => null;

  void update(ErrorData err) => state = err;

  void clear() => state = null;
}
