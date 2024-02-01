import 'package:binah_flutter_sdk/images/image_data.dart';
import 'package:binah_flutter_sdk/images/image_data_listener.dart';
import 'package:binah_poc/models/image/image_validity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BinahImageListener implements ImageDataListener {
  final Ref _ref;

  const BinahImageListener(this._ref);
  @override
  void onImageData(ImageData imageData) {
    _ref
        .read(binahImageValidityProvider.notifier)
        .update(imageData.imageValidity);
  }
}
