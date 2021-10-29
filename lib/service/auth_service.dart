import 'package:firebase_auth/firebase_auth.dart';

// 認証関連サービス
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future createUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateUser({String? name, String? photoURL}) async {
    try {
      User? currentUser = await getCurrentUser();
      currentUser!.updateDisplayName(name);
      currentUser.updatePhotoURL(photoURL);
      print('user info update  success');
    } catch (e) {
      print('user info update error');
    }
  }

  Future<FirebaseAuthResultStatus> login(
      {required String email, required String password}) async {
    FirebaseAuthResultStatus resultStatus;
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = result.user!;
      print('ログインOK:${user.email}');

      if (result.user! != null) {
        resultStatus = FirebaseAuthResultStatus.Successful;
      } else {
        resultStatus = FirebaseAuthResultStatus.Undefined;
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print('ログインNG:${e.toString()}');
      resultStatus = handleException(e);
    }

    return resultStatus;
  }

  Future logout() async {
    try {
      await _firebaseAuth.signOut();
      print('sign out comp');
    } catch (e) {
      print('sign out ng');
      throw e;
    }
  }
}

enum FirebaseAuthResultStatus {
  Successful,
  EmailAlreadyExists,
  WrongPassword,
  InvalidEmail,
  UserNotFound,
  UserDisabled,
  OperationNotAllowed,
  TooManyRequests,
  Undefined,
}

FirebaseAuthResultStatus handleException(FirebaseAuthException e) {
  FirebaseAuthResultStatus result;
  switch (e.code) {
    case 'invalid-email':
      result = FirebaseAuthResultStatus.InvalidEmail;
      break;
    case 'wrong-password':
      result = FirebaseAuthResultStatus.WrongPassword;
      break;
    case 'user-disabled':
      result = FirebaseAuthResultStatus.UserDisabled;
      break;
    case 'user-not-found':
      result = FirebaseAuthResultStatus.UserNotFound;
      break;
    case 'operation-not-allowed':
      result = FirebaseAuthResultStatus.OperationNotAllowed;
      break;
    case 'too-many-requests':
      result = FirebaseAuthResultStatus.TooManyRequests;
      break;
    case 'email-already-exists':
      result = FirebaseAuthResultStatus.EmailAlreadyExists;
      break;
    default:
      result = FirebaseAuthResultStatus.Undefined;
  }
  return result;
}

String exceptionMessage(FirebaseAuthResultStatus result) {
  String? message = '';
  switch (result) {
    case FirebaseAuthResultStatus.Successful:
      message = 'ログインに成功しました。';
      break;
    case FirebaseAuthResultStatus.EmailAlreadyExists:
      message = '指定されたメールアドレスは既に使用されています。';
      break;
    case FirebaseAuthResultStatus.WrongPassword:
      message = 'パスワードが違います。';
      break;
    case FirebaseAuthResultStatus.InvalidEmail:
      message = 'メールアドレスが不正です。';
      break;
    case FirebaseAuthResultStatus.UserNotFound:
      message = '指定されたユーザーは存在しません。';
      break;
    case FirebaseAuthResultStatus.UserDisabled:
      message = '指定されたユーザーは無効です。';
      break;
    case FirebaseAuthResultStatus.OperationNotAllowed:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.TooManyRequests:
      message = '指定されたユーザーはこの操作を許可していません。';
      break;
    case FirebaseAuthResultStatus.Undefined:
      message = '不明なエラーが発生しました。';
      break;
  }
  return message;
}
