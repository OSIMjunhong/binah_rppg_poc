import 'package:binah_flutter_sdk/images/image_validity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_validity.g.dart';

@riverpod
class BinahImageValidity extends _$BinahImageValidity {
  @override
  int build() => 99;

  void update(int value) => state = value;

  @override
  String toString() {
    return switch (state) {
      ImageValidity.valid => 'Normal. Keep it on',
      ImageValidity.invalidDeviceOrientation => 'Invalid device orientation',
      ImageValidity.invalidRoi => 'Invalid ROI',
      ImageValidity.tiltedHead => 'Tilted Head',
      ImageValidity.faceTooFar => 'Face Too Far',
      ImageValidity.unevenLight => 'Uneven Light',
      _ => 'Unknown',
    };
  }
}
