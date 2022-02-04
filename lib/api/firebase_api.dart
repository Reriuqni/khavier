import 'dart:async';

import 'package:admin/model/user_group/user_groups.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/model/user.dart' as SolveUser;
import 'package:admin/model/ticket_static.dart';
import 'package:admin/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String ticketCollection = 'tickets';
String usersCollection = 'users';
String userGroupCollection = 'userGroups';

class FirebaseApi {
  // Processing Tickets

  static Future<String> createTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(ticketCollection).doc();

    ticket.id = docTicket.id;
    await docTicket.set(ticket.toJson());

    return docTicket.id;
  }

  static Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
      .collection(ticketCollection)
      // .orderBy(TicketField.date, descending: true)
      .snapshots()
      .transform(Utils.transformer(Ticket.fromJson) as StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Ticket>>);

  static Future updateTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(ticketCollection).doc(ticket.id);

    await docTicket.update(ticket.toJson());
  }

  static Future deleteTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(ticketCollection).doc(ticket.id);

    await docTicket.delete();
  }

  // Processing Tickets

  // Processing Users

  /// Get User from firebase collection
  ///
  /// `@uid` Firebase authentication user uid.
  /// {@comment example}
  static Future<SolveUser.User?> readOrCreateUser({required AsyncSnapshot<User?> authUser}) async {
    String _uid = authUser.data!.uid;

    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(_uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      print('User exist. uid $_uid');

      docUser.update({'lastSignInTime': authUser.data!.metadata.lastSignInTime, 'lastAccessToFirebase': DateTime.now()});

      return SolveUser.User.fromJson(snapshot.data()!);
    } else {
      print('User is not exist. uid $_uid');

      SolveUser.User newSolveUser = SolveUser.User(
        id: _uid,
        lastSignInTime: authUser.data!.metadata.lastSignInTime,
        lastAccessToFirebase: DateTime.now(),
        firstName: authUser.data?.displayName ?? '',
        email: authUser.data?.email ?? '',
        mobile: authUser.data?.phoneNumber ?? '',
      );

      await createUser(uid: _uid, solveUser: newSolveUser);
      return newSolveUser;
    }
  }

  /// 2do: if snapshot.exists = false
  static Future<SolveUser.User> readUser({required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(uid);
    final snapshot = await docUser.get();

    return SolveUser.User.fromJson(snapshot.data()!);
  }

  static Future<void> deleteUser({required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(uid);
    await docUser.delete();
  }

  static Future<SolveUser.User> createMockUser() async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc();
    SolveUser.User solveUser = SolveUser.User(
      id: docUser.id,
      firstName: 'Empty User',
      lastAccessToFirebase: DateTime.now(),
      lastSignInTime: DateTime.now(),
    );
    await docUser.set(solveUser.toJson());

    return solveUser;
  }

  // Create user and read from Firebase
  // static Future<SolveUser.User> createUser(
  //     {required String uid, required SolveUser.User solveUser}) async {
  //   final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(uid);
  //   await docUser.set(solveUser.toJson());
  //   final snapshot = await docUser.get();
  //   print('Created new User, docId = uid = ${snapshot.id}');
  //   return SolveUser.User.fromJson(snapshot.data()!);
  // }

  static Future<void> createUser({required String uid, required SolveUser.User solveUser}) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(uid);
    await docUser.set(solveUser.toJson());
  }

  static Future<void> updateUser({required SolveUser.User user}) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(user.id);
    await docUser.update(user.toJson());
  }

  static Future<void> deleteUserGroups({required String uid}) async {
    final docUG = FirebaseFirestore.instance.collection(userGroupCollection).doc(uid);
    final ug = await docUG.get();

    UserGroups userGroups = UserGroups.fromJson(ug.data()!);
    if (userGroups.isDdeleteAvailable) {
      docUG.delete();
    }
  }

  static Stream<List<SolveUser.User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      // .orderBy(UserField.date, descending: true)
      .snapshots()
      .transform(
          Utils.transformer(SolveUser.User.fromJson) as StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<SolveUser.User>>);

  static Future<void> updateAccountType({required String uid, required String accountType}) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc(uid);

    await docUser
        .update({'accountType': accountType})
        .then((_) => print('Role success update to $accountType'))
        .catchError((error) => print('Failed: $error'));
  }

  static Future<String> createUserNotUsed(SolveUser.User user) async {
    final docUser = FirebaseFirestore.instance.collection(usersCollection).doc();

    user.id = docUser.id;
    await docUser.set(user.toJson());
    print(user);
    print(docUser.id);

    return docUser.id;
  }

  // Processing Users

  // Processing User Groups

  static Future<void> createUserGroup({required UserGroups userGroup, uid, solveUser}) async {
    final docUG = FirebaseFirestore.instance.collection(userGroupCollection).doc();
    userGroup.id = docUG.id;
    await docUG.set(userGroup.toJson());
  }

  static Future<void> updateUserGroups({required UserGroups userGroups}) async {
    final docUG = FirebaseFirestore.instance.collection(userGroupCollection).doc(userGroups.id);
    await docUG.update(userGroups.toJson());
  }

  // static Stream<List<UserGroups>> readUserGroups() =>
  //     FirebaseFirestore.instance.collection(userGroupCollection).snapshots().transform(Utils.transformer((UserGroups.) as StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<UserGroups>));

  static Future<List<UserGroups>> readUserGroupsOnce() async {
    List<UserGroups> _allUserGroups = [];
    var collection = FirebaseFirestore.instance.collection(userGroupCollection);
    var querySnapshot = await collection.get();
    return snapshotUserGroupsToMap(querySnapshot);
  }

  static List<UserGroups> readUserGroupsAsStreamNotUsed() {
    List<UserGroups> _allUserGroups = [];
    var collection = FirebaseFirestore.instance.collection(userGroupCollection);
    collection.snapshots().listen((querySnapshot) {
      _allUserGroups = snapshotUserGroupsToMap(querySnapshot);
    });
    return _allUserGroups;
  }

  static List<UserGroups> snapshotUserGroupsToMap(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<UserGroups> _allUserGroups = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      _allUserGroups.add(UserGroups.fromJson(data));
    }
    return _allUserGroups;
  }

  static Future<UserGroups> readUserGroup({required String uid}) async {
    final docUG = FirebaseFirestore.instance.collection(userGroupCollection).doc(uid);
    final snapshot = await docUG.get();
    print(snapshot.data());
    print('--------');
    print('--------');
    print(UserGroups.fromJson(snapshot.data()!).id);
    return UserGroups.fromJson(snapshot.data()!);
  }
}
