import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view_model/profile_view_model.dart';
import 'package:wktk/view_model/time_line_view_model.dart';

import 'component/timeline_tile.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProfileViewModel())
    ], child: ProfileViewBody());
  }
}

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        elevation: 3.0,
        shadowColor: Colors.grey,
        child: Container(
            child: Column(
          children: [
            Row(children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                            'https://pbs.twimg.com/profile_images/1242025632805949440/Nkdksb2a_400x400.png'),
                      ))),
              Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'よりおか',
                          style: TextStyle(fontSize: 24),
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
      Flexible(
          child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<TimeLineViewModel>(context, listen: false)
            .getPostList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
