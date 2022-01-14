import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/model/user.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/utils.dart';

String collectionName = 'tickets';

class FirebaseApi {
  // Processing Tickets

  static Future<String> createTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(collectionName).doc();

    ticket.id = docTicket.id;
    await docTicket.set(ticket.toJson());

    return docTicket.id;
  }

  static Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
      .collection(collectionName)
      // .orderBy(TicketField.date, descending: true)
      .snapshots()
      .transform(Utils.transformer(Ticket.fromJson) as StreamTransformer<
          QuerySnapshot<Map<String, dynamic>>, List<Ticket>>);

  static Future updateTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(collectionName).doc(ticket.id);

    await docTicket.update(ticket.toJson());
  }

  static Future deleteTicket(Ticket ticket) async {
    final docTicket =
        FirebaseFirestore.instance.collection(collectionName).doc(ticket.id);

    await docTicket.delete();
  }

  // Processing Tickets

  // Processing Users

  /// Get User from firebase collection
  ///
  /// `@uid` Firebase authentication user uid.
  /// {@comment example}
  static Future<User?> readOrCreateUser({required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      print('User exist. uid $uid');
      // print(User.fromJson(snapshot.data()!));
      return User.fromJson(snapshot.data()!);
    } else {
      // print('User is not exist. uid $uid');

      User user = User();
      await createUser(uid: uid, user: user);
      return user;
    }
  }

  static Future<User> createUser(
      {required String uid, required User user}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    await docUser.set(user.toJson());

    final snapshot = await docUser.get();
    String docID = snapshot.id;
    print('Created new User, docId = uid = $docID');

    return User.fromJson(snapshot.data()!);
  }

  static Future<String> createUserNotUsed(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    user.userId = docUser.id;
    await docUser.set(user.toJson());
    print(user);
    print(docUser.id);

    return docUser.id;
  }

  // Processing Users
}
