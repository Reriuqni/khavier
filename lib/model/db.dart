import 'package:admin/model/model.dart';
import 'package:admin/model/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DataBase {
  late FirebaseAuth auth;
  late User user;
  bool isSigned = false;
  bool isOK = true;
  late CollectionReference ticketsFB;
  List<Ticket> tickets = [];

  DataBase() {
    try {
      print('Database creation...');
      connect();

      auth = FirebaseAuth.instance;
      user = auth.currentUser!;

      print('Database auth user OK');
      isSigned = true;
    } catch (e) {
      print("Database auth user is null: " + e.toString());
      isSigned = false;
      isOK = false;
    }
  }

  connect() {
    ticketsFB = FirebaseFirestore.instance.collection('tickets');
    //devices = FirebaseFirestore.instance.collection('devices');
    //settings = FirebaseFirestore.instance.collection('settings');
    //book = FirebaseFirestore.instance.collection('book');
    //settings.doc("iot_server").get().then((value) => {iotIP = value.data()}); //value.data()['ip']
    print("Database connected!");
  }

  Future<String> getTicketID() async {
    try {
      DocumentReference d = ticketsFB.doc();
      return d.id;
    } catch (e) {
      print("DB error getTicketsID: " + e.toString());
    }
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
          tic.fromMap(doc.data() as Map<String, Object?>);
          tic.id = doc.id;
          tics.add(tic);
        });
      });
      print('Get TicketsFB from Firebase : ' + tics.length.toString());
    } catch (e) {
      print("DB getTickets() error: " + e.toString());
    }

    tickets = tics;
    return tics;
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
  }

  Future<void> updateTicket(Ticket tic) async {
    try {
      await ticketsFB.doc(tic.id).update(tic.toMap());
    } catch (e) {
      print("DB error updateTicket: " + e.toString());
    }
  }

  Future<void> deleteDevice(String id) async {
    await ticketsFB.doc(id).delete();
  }
}
