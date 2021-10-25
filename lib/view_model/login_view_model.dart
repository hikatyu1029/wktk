import 'package:flutter/material.dart';
import 'package:wktk/common/user_common.dart';

class LoginViewModel extends ChangeNotifier {
  late String email;
  late String password;
  bool loginAble = false;

  Future<void> login() async {}

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
