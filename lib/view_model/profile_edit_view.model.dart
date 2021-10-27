import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wktk/service/image_service.dart';

// 状態を保持する
// プロフィール関連の状態を保持
class ProfileEditViewModel extends ChangeNotifier {
  Image profileImage = Image.network(
      'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png');

  void setProfileImage(Image img) {
    profileImage = img;
    notifyListeners();
  }
}
