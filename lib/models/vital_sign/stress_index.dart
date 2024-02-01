import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stress_index.g.dart';

@riverpod
class StressIndex extends _$StressIndex {
  @override
  int build() => 0;

  void update(int value) => state = value;
}
