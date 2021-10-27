import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view/main_view.dart';
import 'package:wktk/view_model/profile_edit_view.model.dart';

class ProfileEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProfileEditViewModel())
    ], child: ProfileEditViewBody());
  }
}

// 画面表示が責務
// プロフィール画像を表示する部分
class ProfileEditViewBody extends StatelessWidget {
  Widget build(BuildContext context) {
    var vm = Provider.of<ProfileEditViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(''), flex: 2),
          Text('アカウントを作成しました！', style: TextStyle(fontSize: 28)),
          Text('プロフィール画像とアカウント名を設定しましょう。', style: TextStyle(fontSize: 18)),
          Expanded(child: Text(''), flex: 1),
          Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: (vm.profileImage.image),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                    child: InkWell(
                      onTap: () async {
                        // Pick an image
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        vm.setProfileImage(Image.file(File(image!.path)));
                      },
                    ),
                  ),
                ),
              )
              // IconButton(
              //     onPressed: () async {
              //       // Pick an image
              //       final ImagePicker _picker = ImagePicker();
              //       final XFile? image =
              //           await _picker.pickImage(source: ImageSource.gallery);
              //       vm.setProfileImage(Image.file(File(image!.path)));
              //     },
              //     icon: vm.profileImage),
              ),
          Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                decoration: InputDecoration(labelText: "ユーザー名"),
                onChanged: (String value) {},
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
              child: TextFormField(
                style: TextStyle(color: Colors.grey),
                controller: TextEditingController()..text = 'aaaaa@bbbbbn.com',
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {},
                enableInteractiveSelection: false,
                enabled: false,
              )),
          Container(
              margin: EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () async {
                  // TODO:アカウント作成画面への遷移

                  print('アカウント作成画面へ');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainView()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                child: Container(
                    child: Text(
                  '「w k t k」をはじめる',
                  style: TextStyle(fontSize: 24, fontFamily: 'Rampart One'),
                )),
              )),
          Expanded(child: Text(''), flex: 3)
        ],
      )),
    );
  }
}
