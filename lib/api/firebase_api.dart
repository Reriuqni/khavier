import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/utils.dart';

String collectionName = 'tickets';

class FirebaseApi {
  static Future<String> createTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(collectionName).doc();

    ticket.id = docTicket.id;
    await docTicket.set(ticket.toJson());

    return docTicket.id;
  }

  static Stream<List<Ticket>> readTickets() => FirebaseFirestore.instance
      .collection(collectionName)
      // .orderBy(TicketField.date, descending: true)
      .snapshots()
      .transform(Utils.transformer(Ticket.fromJson));

  static Future updateTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(collectionName).doc(ticket.id);

    await docTicket.update(ticket.toJson());
  }

  static Future deleteTicket(Ticket ticket) async {
    final docTicket = FirebaseFirestore.instance.collection(collectionName).doc(ticket.id);

    await docTicket.delete();
  }
}
