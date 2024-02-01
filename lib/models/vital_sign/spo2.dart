import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'spo2.g.dart';

@riverpod
class Spo2 extends _$Spo2 {
  @override
  int build() => 0;

  void update(int value) => state = value;
}
