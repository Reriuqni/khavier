// import 'package:admin/api/firebase_api.dart';
// import 'package:admin/apps/shimmer_app_loading.dart';
// import 'package:admin/controllers/MenuController.dart';
// import 'package:admin/apps/create_app.dart';
// import 'package:admin/model/user.dart' as SolveUser;
// import 'package:admin/provider/NewVersionUserProvider.dart';
// import 'package:admin/provider/TicketsProvider.dart';
// import 'package:admin/routes/roles.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:nested/nested.dart';
// import 'package:provider/provider.dart';

// import '../auth/init.dart'
//     if (dart.library.html) 'auth/web_init.dart'
//     if (dart.library.io) 'auth/io_init.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeFirebase();
//   runApp(AuthenticationGate());
// }

// class AuthenticationGate extends StatefulWidget {
//   const AuthenticationGate({Key? key}) : super(key: key);

//   @override
//   State<AuthenticationGate> createState() => _AuthenticationGateState();
// }

// class _AuthenticationGateState extends State<AuthenticationGate> {
//   @override
//   Widget build(BuildContext context) {
//     final auth = FirebaseAuth.instance;

//     return StreamBuilder<User?>(
//       // stream: FirebaseAuth.instance.authStateChanges(),
//       stream: auth.userChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         // User is not signed in - show a sign-in screen
//         if (!snapshot.hasData) {
//           return CreateApp(userRole: Roles.AUTH);
//         }

//         String _uid = snapshot.data!.uid;
//         SolveUser.User newSolveUser = SolveUser.User(
//           id: _uid,
//           lastSignInTime: snapshot.data!.metadata.lastSignInTime,
//           firstName: snapshot.data?.displayName ?? '',
//           email: snapshot.data?.email ?? '',
//           mobile: snapshot.data?.phoneNumber ?? '',
//         );

//         // show app’s home page after login
//         return FutureBuilder(
//           future: FirebaseApi.readOrCreateUser(uid: _uid, user: newSolveUser),
//           builder: (BuildContext context,
//               AsyncSnapshot<SolveUser.User?> userSnapshot) {
//             if (userSnapshot.connectionState == ConnectionState.waiting) {
//               return ShimmerLoading(
//                   text: 'Loading User Data...', subText: _uid);
//             }

//             if (userSnapshot.hasData) {
//               final solveUser = userSnapshot.data;

//               if (solveUser == null) {
//                 return CreateApp(userRole: Roles.AUTH);
//               } else {
//                 return MultiProvider(
//                   providers: listProviders,
//                   child: CreateApp(userRole: solveUser.accountType),
//                 );
//               }
//             } else {
//               return ShimmerLoading(
//                   text:
//                       'Unfortunately No Such User in DB. Please, ask admin to create User',
//                   subText: _uid,
//                   isShimEnabled: false,
//                   isShowSignOut: true);
//             }
//           },
//         );
//       },
//     );
//   }

//   List<SingleChildWidget> get listProviders {
//     return [
//       ChangeNotifierProvider(
//         create: (context) => MenuController(),
//       ),
//       ChangeNotifierProvider(create: (context) => TicketsProvider()),
//       ChangeNotifierProvider(create: (context) => NewVersionUserProvider()),
//     ];
//   }
// }
