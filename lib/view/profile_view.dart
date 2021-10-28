import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:wktk/service/auth_service.dart';
import 'package:wktk/view/profile_edit_view.dart';
import 'package:wktk/view_model/profile_view_model.dart';
import 'package:wktk/view_model/time_line_view_model.dart';

import 'component/timeline_tile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProfileViewModel())
    ], child: CurrentUserGetFutureBuilder());
  }
}

class CurrentUserGetFutureBuilder extends StatelessWidget {
  Widget build(BuildContext context) {
    var vm = Provider.of<ProfileViewModel>(context, listen: false);
    return FutureBuilder(
        future: AuthService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            vm.currentUser = snapshot.data as User?;
            return ProfileViewBody();
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class ProfileViewBody extends StatelessWidget {
  Widget build(BuildContext context) {
    var vm = Provider.of<ProfileViewModel>(context, listen: false);

    return Column(children: [
      Expanded(
        flex: 2,
        child: Card(
          elevation: 3.0,
          shadowColor: Colors.grey,
          child: Container(
              child: Column(
            children: [
              Row(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Ink.image(
                            image: (Image.network(
                                    'https://pbs.twimg.com/profile_images/479856017438556160/TUPKOb9i_400x400.jpeg')
                                .image),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            child: InkWell(
                              onTap: () async {},
                            ),
                          ),
                        ),
                      )),
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vm.currentUser!.displayName ?? 'ゲスト',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  height: 24,
                                  child: OutlinedButton(
                                      style: ButtonStyle(),
                                      onPressed: () {
                                        showBarModalBottomSheet(
                                          expand: false,
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          builder: (context) =>
                                              ProfileEditView(),
                                        );
                                      },
                                      child: Text('プロフィールを編集')))
                            ],
                          ),
                          Text(
                              '仕事がつまらない日常から解放されたい欲求が高いです。さっさと楽しい仕事ができるように頑張ります。ここでは楽しい日常を少しずつ見つけていきたいと思います。')
                        ],
                      ),
                    )),
              ]),
              Container(
                  child: Column(
                children: const [
                  Text(
                    '145',
                    style: TextStyle(fontSize: 32),
                  ),
                  Text('wktk')
                ],
              )),
            ],
          )),
        ),
      ),
      Expanded(
          flex: 5,
          child: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<TimeLineViewModel>(context, listen: false)
                .getPostList(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('読み込みに失敗しました。');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return TimelineTile(data['text']);
                }).toList(),
              );
            },
          ))
    ]);
  }
}
