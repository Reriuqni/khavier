import 'package:admin/model/db.dart';
import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
// class Model {
  DataBase db = new DataBase();
  bool isOnline = false;
}
