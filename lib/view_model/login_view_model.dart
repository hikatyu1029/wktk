import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/common/user_common.dart';
import 'package:wktk/service/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool loginAble = false;

  // ログイン処理を実行
  // ログイン処理の結果FirebaseAuthResultStatusを返却
  Future<FirebaseAuthResultStatus> login() async {
    // メール/パスワードでログイン
    return await AuthService().login(email: email, password: password);
  }

  void checkLoginAble() {
    if (checkEmail() && checkPassword()) {
      loginAble = true;
      notifyListeners();
      return;
    }
    loginAble = false;
    notifyListeners();
  }

  bool checkEmail() {
    return UserCommon.checkEmailFormat(email);
  }

  bool checkPassword() {
    return UserCommon.checkPasswordFormat(password);
  }
}
