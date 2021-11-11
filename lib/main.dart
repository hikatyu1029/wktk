import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view/component/bottom_navigation_bar.dart';
import 'package:wktk/view/login_view.dart';
import 'package:wktk/view/start_view.dart';
import 'package:wktk/view/main_view.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => BottomNavigationBarProvider()),
        ],
        child: MaterialApp(
          initialRoute: '/wktk',
          routes: {'/wktk': (context) => StartView()},
          title: 'wktk',
          theme: ThemeData(primarySwatch: Colors.deepOrange),

          darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              brightness: Brightness.dark,
              accentColor: Colors.deepOrangeAccent),
          // テーマのモードは端末の設定によるものにする
          themeMode: ThemeMode.system,
          home: StartView(),
        ));
  }
}
