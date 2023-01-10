import 'package:flutter/material.dart';

import 'data_servers.dart';


class UserProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}