import 'package:admin/model/user_group/user_groups.dart';
import 'package:flutter/material.dart';

class UserGroupsProvider extends ChangeNotifier {
  UserGroups _userGroups = UserGroups();

  UserGroups get userGroups => _userGroups;
}