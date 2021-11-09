import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:wktk/service/auth_service.dart';
import 'package:wktk/view/main_view.dart';
import 'package:wktk/view/profile_register_view.dart';
import 'package:wktk/view_model/sign_up_view_model.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpViewModel())
      ],
      child: SignUpViewBody(),
    );
  }
}

class SignUpViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SignUpViewModel>(context);
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(''),
          flex: 1,
        ),
        Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "メールアドレス"),
                  onChanged: (String value) {
                    vm.newUserEmail = value;
                    vm.checkRegistrable();
                  },
                )),
            // パスワードの入力フォーム
            Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 10.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "パスワード（8～20文字）"),
                obscureText: true, // パスワードが見えないようRにする
                maxLength: 20, // 入力可能な文字数
                onChanged: (String value) {
                  vm.newUserPassword = value;
                  vm.checkRegistrable();
                },
              ),
            ),
            Container(
                margin: EdgeInsets.all(50),
                child: ElevatedButton(
                  onPressed: !vm.registrable
                      ? null
                      : () async {
                          try {
                            vm.SignUp();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileRegisterView()));
                            return;
                          } catch (e) {
                            // TODO:Sign up　処理のエラーハンドリング
                            rethrow;
                          }
                        },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                  child: Container(
                      child: Text(
                    'メールアドレスで登録',
                    style: TextStyle(fontSize: 24),
                  )),
                )),
          ],
        ),
        Expanded(
          child: Text(''),
          flex: 1,
        ),
        // TODO:Googleサインアップの実装
        // SignInButton(
        //   Buttons.Google,
        //   shape: new RoundedRectangleBorder(
        //     borderRadius: new BorderRadius.circular(0.0),
        //   ),
        //   text: 'Googleで登録',
        //   onPressed: () async {
        //     try {
        //       final userCredential = await signInWithGoogle();
        //     } on FirebaseAuthException catch (e) {
        //       print('google firebaseauthexception error');
        //     } on Exception catch (e) {
        //       print('error');
        //       print('${e.toString()}');
        //     }
        //   },
        // ),
        Expanded(
          child: Text(''),
          flex: 1,
        )
      ],
    )));
  }

  // Googleを使ってサインイン
  Future<UserCredential> signInWithGoogle() async {
    // 認証フローのトリガー
    final googleUser = await GoogleSignIn(scopes: [
      'email',
    ]).signIn();
    // リクエストから、認証情報を取得
    final googleAuth = await googleUser!.authentication;
    // クレデンシャルを新しく作成
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // サインインしたら、UserCredentialを返す
    return FirebaseAuth.instance.signInWithCredential(credential);
  }
}
