import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/common/user_common.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool loginAble = false;

  Future<void> login() async {
    // メール/パスワードでログイン
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ログインに成功した場合
      final User user = result.user!;
      print("ログインOK：${user.email}");
    } catch (e) {
      print("ログインNG：${e.toString()}");
    }
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
