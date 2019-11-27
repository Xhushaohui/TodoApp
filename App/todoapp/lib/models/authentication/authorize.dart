import 'dart:async';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  var currentUser;

  AuthService() {
    print("new AuthService");
  }

  Future getUser() {
    return Future.value(currentUser);
  }

  Future logOut() {
    this.currentUser = null;
    notifyListeners();
    return Future.value(currentUser);
  }

  Future createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {}
  Future loginUser({String email, String password}) {
    if (password == 'password123') {
      this.currentUser = {'email': email};
      notifyListeners();
      return Future.value(currentUser);
    } else {
      this.currentUser = null;
      return Future.value(null);
    }
  }
}
