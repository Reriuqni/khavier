import 'package:admin/model/ticket_static.dart';
import 'package:admin/api/firebase_api.dart';
import 'package:flutter/material.dart';

class TicketsProvider extends ChangeNotifier {
  List<Ticket>? _tickets = [];

  List<Ticket> get ticketsStatusMedium =>
      _tickets!.where((ticket) => ticket.status == 'Medium').toList();
  List<Ticket> get ticketsCompleted =>
      _tickets!.where((ticket) => ticket.status == 'Low').toList();

  void setTickets(List<Ticket>? tickets) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _tickets = tickets;
        notifyListeners();
      });

  List<Ticket>? get tickets => _tickets;
  void addTicket(Ticket ticket) => FirebaseApi.createTicket(ticket);
  void removeTicket(Ticket ticket) => FirebaseApi.deleteTicket(ticket);

  void updateTicket(Ticket ticket) => FirebaseApi.updateTicket(ticket);
  // void updateTicket(Ticket ticket, String name, String body, String type) {
  //   ticket.name = name;
  //   ticket.body = body;
  //   ticket.type = type;

  //   FirebaseApi.updateTicket(ticket);
  // }

  bool? toggleTicketStatus(Ticket ticket) {
    ticket.isDone = !ticket.isDone!;
    FirebaseApi.updateTicket(ticket);

    return ticket.isDone;
  }
}
