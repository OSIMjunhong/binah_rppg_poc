import 'package:binah_flutter_sdk/images/image_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_data.g.dart';

@riverpod
class BinahImageData extends _$BinahImageData {
  @override
  ImageData? build() => null;

  void update(ImageData? value) => state = value;
}
