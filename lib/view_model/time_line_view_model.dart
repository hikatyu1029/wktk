import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeLineViewModel extends ChangeNotifier {
  Stream<QuerySnapshot> getPostList() {
    final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance
        .collection('post')
        .orderBy('created_at', descending: true)
        .snapshots();
    return _postStream;
  }
}

class Post {
  late String post;
  late int favorites;
  late int comments;
  late String user_id;
}
