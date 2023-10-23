import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Pick image from the gallery and camera.
class PickImage {
  // Pick image from the gallery.
  Future<String?> imageFormGallery({
    required BuildContext context,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    return pickedFile.path;
  }

  // Pick image from the camera.
  Future<String?> imageFormCamera({
    required BuildContext context,
  }) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return null;
    }
    return pickedFile.path;
  }
}
