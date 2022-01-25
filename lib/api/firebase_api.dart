import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/model/user.dart' as SolveUser;
import 'package:admin/model/ticket_static.dart';
import 'package:admin/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String ticketCollection = 'tickets';
String usersCollection = 'users';

class FirebaseApi {
  // Processing Tickets

  static Future<String> createTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(ticketCollection).doc();

    ticket.id = docTicket.id;
    await docTicket.set(ticket.toJson());

    return docTicket.id;
  }

  static Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
      .collection(ticketCollection)
      // .orderBy(TicketField.date, descending: true)
      .snapshots()
      .transform(Utils.transformer(Ticket.fromJson) as StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<Ticket>>);

  static Future updateTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(ticketCollection).doc(ticket.id);

    await docTicket.update(ticket.toJson());
  }

  static Future deleteTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(ticketCollection).doc(ticket.id);

    await docTicket.delete();
  }

  // Processing Tickets

  // Processing Users

  /// Get User from firebase collection
  ///
  /// `@uid` Firebase authentication user uid.
  /// {@comment example}
  static Future<SolveUser.User?> readOrCreateUser(
      {required AsyncSnapshot<User?> authUser}) async {
    String _uid = authUser.data!.uid;

    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(_uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      print('User exist. uid $_uid');

      docUser
          .update({'lastSignInTime': authUser.data!.metadata.lastSignInTime});

      return SolveUser.User.fromJson(snapshot.data()!);
    } else {
      print('User is not exist. uid $_uid');

      SolveUser.User newSolveUser = SolveUser.User(
        id: _uid,
        lastSignInTime: authUser.data!.metadata.lastSignInTime,
        firstName: authUser.data?.displayName ?? '',
        email: authUser.data?.email ?? '',
        mobile: authUser.data?.phoneNumber ?? '',
      );

      await createUser(uid: _uid, solveUser: newSolveUser);
      return newSolveUser;
    }
  }

  static Future<SolveUser.User> readUser({required String uid}) async {
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(uid);
    final snapshot = await docUser.get();

    return SolveUser.User.fromJson(snapshot.data()!);
  }

  static Future<SolveUser.User> createUser(
      {required String uid, required SolveUser.User solveUser}) async {
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(uid);
    await docUser.set(solveUser.toJson());

    final snapshot = await docUser.get();
    String docID = snapshot.id;
    print('Created new User, docId = uid = $docID');

    return SolveUser.User.fromJson(snapshot.data()!);
  }

  static Stream<List<SolveUser.User>> readUsers() => FirebaseFirestore.instance
      .collection(usersCollection)
      // .orderBy(UserField.date, descending: true)
      .snapshots()
      .transform(Utils.transformer(SolveUser.User.fromJson)
          as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<SolveUser.User>>);

  static Future<void> updateAccountType(
      {required String uid, required String accountType}) async {
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc(uid);

    await docUser
        .update({'accountType': accountType})
        .then((_) => print('Role success update to $accountType'))
        .catchError((error) => print('Failed: $error'));
  }

  static Future<String> createUserNotUsed(SolveUser.User user) async {
    final docUser =
        FirebaseFirestore.instance.collection(usersCollection).doc();

    user.id = docUser.id;
    await docUser.set(user.toJson());
    print(user);
    print(docUser.id);

    return docUser.id;
  }

  // Processing Users
}
