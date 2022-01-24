// import 'package:admin/constants/texts.dart';
// import 'package:admin/widgets/buttons.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// /*
//   /// example of used
//   // #1
//     return ShimmerLoading(
//       text:
//           'Unfortunately No Such User in DB. Please, ask admin to create User',
//       subText: _uid,
//       isShimEnabled: false,
//       isShowSignOut: true);

//   // #2
//   return ShimmerLoading(
//   text: 'Loading User Data...', subText: _uid);
// */

// class ShimmerLoading extends StatelessWidget {
//   const ShimmerLoading({
//     Key? key,
//     this.text = 'Loading...',
//     this.subText = '',
//     this.isShimEnabled = true,
//     this.isShowSignOut = false,
//   }) : super(key: key);

//   final String text;
//   final String? subText;
//   final bool isShimEnabled;
//   final bool isShowSignOut;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: PROJECT_NAME,
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(
//           color: Colors.white,
//           padding: EdgeInsets.only(top: 25),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     Shimmer.fromColors(
//                       baseColor: Colors.red,
//                       highlightColor: Colors.yellow,
//                       child: Text(
//                         text,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30,
//                           // decorationStyle: TextDecorationStyle.wavy,
//                           foreground: Paint()
//                             ..style = PaintingStyle.stroke
//                             ..color = Colors.blue[100]!,
//                         ),
//                       ),
//                       enabled: isShimEnabled,
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
//                               child: OwnButtonWithICon(
//                                 onPressed: () {
//                                   Clipboard.setData(
//                                       ClipboardData(text: subText));
//                                 },
//                                 icon: FontAwesomeIcons.copy,
//                                 label: "uid",
//                               ),
//                             ),
//                             SelectableText(
//                               (subText ?? 'no uid'),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         )),
//                     if (isShowSignOut) ...[
//                       OwnButtonWithICon(
//                         onPressed: () async {
//                           await FirebaseAuth.instance.signOut();
//                           Navigator.pushNamed(context, '/');
//                         },
//                         icon: FontAwesomeIcons.signOutAlt,
//                         label: "SignOut",
//                       ),
//                     ],
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
