import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_validity.g.dart';

@riverpod
class BinahImageValidity extends _$BinahImageValidity {
  @override
  String build() => '';

  void update(int value) {
    switch (value) {
      case 0:
        state = 'Measuring, please hold on...';
        break;
      case 1:
        state = 'Invalid device orientation';
        break;
      case 2:
        state = 'Invalid ROI';
        break;
      case 3:
        state = 'Tilted Head';
        break;
      case 4:
        state = 'Face Too Far';
        break;
      case 5:
        state = 'Uneven Light';
        break;
    }
  }
}
