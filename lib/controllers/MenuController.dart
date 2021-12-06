import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKeyMenuController = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKeyMenuController;

  void controlMenu() {
    if (!_scaffoldKeyMenuController.currentState.isDrawerOpen) {
      _scaffoldKeyMenuController.currentState.openDrawer();
    }
  }
}
