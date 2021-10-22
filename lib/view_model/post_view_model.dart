import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  late String _postText;

  String get postText => _postText;

  set postText(String s) {
    if (s.isNotEmpty) {
      _postText = s;
    }
  }

  Future<void> AddPost() async {
    CollectionReference post = FirebaseFirestore.instance.collection('post');
    notifyListeners();
    return post
        .add({
          'text': _postText,
          'user_id': 'test_user',
          'created_at': Timestamp.now(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
