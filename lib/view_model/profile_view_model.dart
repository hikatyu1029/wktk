import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wktk/service/auth_service.dart';
import 'package:wktk/view/profile_view.dart';

class ProfileViewModel extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  set currentUser(User? user) {
    _currentUser = user;
  }
}
