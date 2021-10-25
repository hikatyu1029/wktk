import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view/sign_up_view.dart';
import 'package:wktk/view_model/login_view_model.dart';

import 'login_view.dart';

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel())
      ],
      child: StartViewBody(),
    );
  }
}

class StartViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
      Expanded(child: Text(''), flex: 2),
      const Text(
        '今日の「w k t k」',
        style: TextStyle(fontSize: 30, fontFamily: 'Rampart One'),
      ),
      const Text(
        '見つけよう、シェアしよう。',
        style: TextStyle(fontSize: 30, fontFamily: 'Rampart One'),
      ),
      Container(
          margin: EdgeInsets.all(50),
          child: ElevatedButton(
            onPressed: () async {
              // TODO:アカウント作成画面への遷移

              print('アカウント作成画面へ');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpView()));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            child: Container(
                child: Text(
              'アカウントを作成',
              style: TextStyle(fontSize: 24),
            )),
          )),
      Expanded(child: Text(''), flex: 1),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('アカウントをお持ちの方は'),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            child: const Text(
              'ログイン',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text('してください。')
        ],
      ),
      Expanded(
        child: Text(''),
        flex: 1,
      )
    ])));
  }
}
