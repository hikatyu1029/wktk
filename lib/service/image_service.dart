import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  // singletonのため
  static ImageService? _instance;
  factory ImageService() => _instance ??= ImageService();

  final _picker = ImagePicker();

  Future getImage() async {
    final _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      return File(_pickedFile.path);
    } else {
      NullThrownError();
    }
  }
}
