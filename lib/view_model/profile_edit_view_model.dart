import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/service/auth_service.dart';
import 'package:wktk/service/image_service.dart';

// 状態を保持する
// プロフィール関連の状態を保持
class ProfileEditViewModel extends ChangeNotifier {
  ProfileEditViewModel() {
    () async {
      _currentUser = await AuthService().getCurrentUser();
    };
  }

  User? _currentUser;

  String? _currentUserName;

  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
  }

  set currentUserName(String s) {
    _currentUserName = s;
  }

  Image profileImage = Image.network(
      'https://cdn.icon-icons.com/icons2/1674/PNG/512/person_110935.png');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void setProfileImage(Image img) {
    profileImage = img;
    notifyListeners();
  }

  Future updateCurrentUser() async {
    _currentUserName ??= 'ゲスト';
    return await AuthService().updateUser(name: _currentUserName);
  }
}
