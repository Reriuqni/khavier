import 'package:admin/model/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataBase extends ChangeNotifier {
  CollectionReference ticketsFB;
  List<Ticket> tickets = [];

  DataBase() {
    try {
      print('Database creation...');
      connect();
    } catch (e) {
      // print("Database auth user is null: " + e.toString());
    }
  }

  connect() {
    ticketsFB = FirebaseFirestore.instance.collection('tickets');
    print("Database connected!");
    //settings = FirebaseFirestore.instance.collection('settings');
    //settings.doc("iot_server").get().then((value) => {iotIP = value.data()}); //value.data()['ip']
  }

  Future<String> getTicketID() async {
    try {
      DocumentReference d = ticketsFB.doc();
      return d.id;
    } catch (e) {
      print("DB error getTicketsID: " + e.toString());
    }

    notifyListeners();
    return "";
  }

  Future<List<Ticket>> getTickets({String userUid = ''}) async {
    tickets = [];
    List<Ticket> tics = [];
    try {
      await ticketsFB
          // .where("owner", isEqualTo: userUid) //.orderBy("date")
          .get()
          .then((QuerySnapshot value) {
        value.docs.forEach((doc) {
          Ticket tic = Ticket();
          tic.fromMap(doc.data() as Map<String, Object>);
          tic.id = doc.id;
          tics.add(tic);
        });
      });
      print('Get TicketsFB from Firebase : ' + tics.length.toString());
    } catch (e) {
      print("DB getTickets() error: " + e.toString());
    }

    tickets = tics;

    notifyListeners();
    return tics;
  }

  Ticket getTicketById(String id) {
    for (var i = 0; i < tickets.length; i++) {
      if (tickets[i].id == id) {
        return tickets[i];
      }
    }
    return Ticket();
  }

  Future<void> addTicket(Ticket tic) async {
    tic.date = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      if (tic.id.isEmpty) {
        await ticketsFB.add(tic.toMap());
      } else {
        await ticketsFB.doc(tic.id).set(tic.toMap());
      }
    } catch (e) {
      print("DB error setTicket: " + e.toString());
    }

    notifyListeners();
  }

  Future<void> updateTicket(Ticket tic) async {
    try {
      await ticketsFB.doc(tic.id).update(tic.toMap());
    } catch (e) {
      print("DB error updateTicket: " + e.toString());
    }

    notifyListeners();
  }

  Future<void> deleteTicket(String id) async {
    await ticketsFB.doc(id).delete();
    notifyListeners();
  }
}
