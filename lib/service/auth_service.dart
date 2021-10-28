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
}
