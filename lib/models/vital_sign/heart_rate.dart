import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'heart_rate.g.dart';

@riverpod
class HeartRate extends _$HeartRate {
  @override
  int build() => 0;

  void update(int value) => state = value;
}
