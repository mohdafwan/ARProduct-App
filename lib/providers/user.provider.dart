import 'package:flutter/material.dart';
import 'package:interior_design_arapp/models/user.model.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    username: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
