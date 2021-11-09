import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/common/user_common.dart';
import 'package:wktk/service/auth_service.dart';

class SignUpViewModel extends ChangeNotifier {
  late String newUserEmail = '';
  late String newUserPassword = '';
  bool registrable = false;

  Future<void> AddUserWithEMail() async {
    return;
  }

  void checkRegistrable() {
    if (checkEmail() && checkPassword()) {
      registrable = true;
      notifyListeners();
      return;
    }
    registrable = false;
    notifyListeners();
  }

  bool checkPassword() {
    return UserCommon.checkPasswordFormat(newUserPassword);
  }

  bool checkEmail() {
    return UserCommon.checkEmailFormat(newUserEmail);
  }

  Future<void> SignUp() async {
    try {
      // メールアドレス、パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      AuthService().createUser(newUserEmail, newUserPassword);
    } catch (e) {
      // TODO:Sign up処理のエラーハンドリング
      rethrow;
    }
  }
}
