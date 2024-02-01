import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'respiration_rate.g.dart';

@riverpod
class RespirationRate extends _$RespirationRate {
  @override
  int build() => 0;

  void update(int value) => state = value;

  @override
  String toString() => state == 0 ? '-' : '$state';
}
