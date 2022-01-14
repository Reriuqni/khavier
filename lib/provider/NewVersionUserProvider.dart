import 'package:admin/model/user.dart';
import 'package:flutter/material.dart';

class NewVersionUserProvider extends ChangeNotifier {
  List<User>? _users = [];

  void setUsers(List<User>? users) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _users = users;
        notifyListeners();
      });

  List<User>? get tickets => _users;      
}
