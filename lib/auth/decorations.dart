import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

HeaderBuilder headerImage(String assetName) {
  return (context, constraints, _) {
    return getBgWithLogo(assetName);
  };
}

SideBuilder sideImage(String assetName) {
  return (context, constraints) {
    return getBgWithLogo(assetName, isSide: true);
  };
}

Center getBgWithLogo(String assetName, {bool isSide = false}) {
  return Center(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                  fit: BoxFit.cover,
                  image:
                      NetworkImage("assets/images/auth_screen/auth_bg.jpg"))),
          child: Container(
            child: Center(
                child: Container(
              width: isSide ? 400 : 300,
              child: Image.asset(assetName),
            )),
          )));
}

HeaderBuilder headerIcon(IconData icon) {
  return (context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(top: 40),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 4 * (1 - shrinkOffset),
      ),
    );
  };
}

SideBuilder sideIcon(IconData icon) {
  return (context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 3,
      ),
    );
  };
}
