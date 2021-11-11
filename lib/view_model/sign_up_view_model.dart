import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/common/user_common.dart';
import 'package:wktk/service/auth_service.dart';

class SignUpViewModel extends ChangeNotifier {
  late String newUserEmail = '';
  late String newUserPassword = '';
  bool registrable = false;

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

  /// VMで保持しているemail,passwordで新規会員登録
  Future<FirebaseAuthResultStatus> SignUp() async {
    return await AuthService().createUser(newUserEmail, newUserPassword);
  }
}
