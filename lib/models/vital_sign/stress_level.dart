import 'package:binah_flutter_sdk/vital_signs/vitals/stress_level.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stress_level.g.dart';

@riverpod
class Stress extends _$Stress {
  @override
  StressLevel build() => StressLevel.unknown;

  void update(StressLevel value) => state = value;

  @override
  String toString() => state == StressLevel.unknown ? '-' : state.name;
}
