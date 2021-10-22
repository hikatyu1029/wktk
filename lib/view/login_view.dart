import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view/time_line_view.dart';
import 'package:wktk/view_model/login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel())
      ],
      child: LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<LoginViewModel>(context, listen: false);
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
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainView()));
            },
            child: Text('ログイン'),
          )
        ],
      ),
    ));
  }
}
