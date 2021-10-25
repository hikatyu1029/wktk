/// ユーザー関連の共通項目
class UserCommon {
  // インスタンス化はさせない
  UserCommon._();

  // emailのフォーマットチェック
  static bool checkEmailFormat(String s) {
    if (s != null &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(s)) {
      return true;
    }
    return false;
  }

// パスワードのフォーマット（というより文字数）チェック
  static bool checkPasswordFormat(String s) {
    if (s.length >= 8 && s.length <= 20) {
      return true;
    }
    return false;
  }
}
