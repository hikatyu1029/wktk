import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wktk/view_model/post_view_model.dart';

import 'component/bottom_navigation_bar.dart';

class PostView extends StatelessWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PostViewModel())
    ], child: PostViewBody());
  }
}

class PostViewBody extends StatelessWidget {
  final _postTextController = TextEditingController();

  PostViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('キャンセル')),
            ElevatedButton(
                onPressed: () {
                  var vm = Provider.of<PostViewModel>(context, listen: false);
                  vm.postText = _postTextController.text;
                  vm.AddPost();
                  Navigator.pop(context);
                },
                child: const Text(
                  '投稿',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _postTextController,
            autofocus: true,
            maxLines: 8,
            decoration: const InputDecoration.collapsed(
                hintText: "今日はどんな「wktk」がありましたか？"),
          ),
        ),
      ],
    );
  }
}
