import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/service/auth_service.dart';
import 'package:wktk/view/main_view.dart';
import 'package:wktk/view_model/login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel())
      ],
      child: const LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<LoginViewModel>(context);
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'みんなの「w k t k」',
            style: TextStyle(fontSize: 30, fontFamily: 'Rampart One'),
          ),
          // メールアドレスの入力フォーム
          Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  vm.email = value;
                  vm.checkLoginAble();
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
                vm.password = value;
                vm.checkLoginAble();
              },
            ),
          ),
          ElevatedButton(
            onPressed: !vm.loginAble
                ? null
                : () async {
                    FirebaseAuthResultStatus result = await vm.login();
                    if (result == FirebaseAuthResultStatus.Successful) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainView()));
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text('エラー'),
                            children: [
                              SimpleDialogOption(
                                child: Text(exceptionMessage(result)),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          );
                        });
                  },
            child: Text('ログイン'),
          )
        ],
      ),
    ));
  }
}
