import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Pick image from the gallery.
class PickImage {
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
}
