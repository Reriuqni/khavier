import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

HeaderBuilder headerImage(String assetName) {
  return (context, constraints, _) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                fit: BoxFit.cover,
                image: NetworkImage("assets/assets/images/team.jpg"))),
        child: Container(
        // width: 600,
        // height: 600,
        // decoration: BoxDecoration(color: Colors.black54.withOpacity(0.6)),
        child: Center(
          child: Container(
            // width: 300,
            // height: 220,
            child:Image.asset(assetName),))
        
        //
        ,
      ));
  };
}

SideBuilder sideImage(String assetName) {
  return (context, constraints) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
                fit: BoxFit.cover,
                image: NetworkImage("assets/assets/images/team.jpg"))),
        child: Container(
        // width: 600,
        // height: 600,
        // decoration: BoxDecoration(color: Colors.black54.withOpacity(0.6)),
        child: Center(
          child: Container(
            // width: 300,
            // height: 220,
            child:Image.asset(assetName),))
        
        //
        ,
      )));
  };
}

// HeaderBuilder headerImage(String assetName) {
//   return (context, constraints, _) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Image.asset(assetName),
//     );
//   };
// }

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

// SideBuilder sideImage(String assetName) {
//   return (context, constraints) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(constraints.maxWidth / 4),
//         child: Image.asset(assetName),
//       ),
//     );
//   };
// }

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
