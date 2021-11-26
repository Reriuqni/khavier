import 'package:admin/model/ticket_static.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin/api/firebase_api.dart';

class TicketsProvider extends ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get tickets0 => _tickets.where((ticket) => ticket.isDone == false).toList();
  List<Ticket> get tickets => _tickets;

  List<Ticket> get ticketsCompleted =>
      _tickets.where((ticket) => ticket.isDone == true).toList();

  void setTickets(List<Ticket> tickets) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('setTickets: ' + tickets.length.toString());
        _tickets = tickets;
        notifyListeners();
      });

  void addTicket(Ticket ticket) => FirebaseApi.createTicket(ticket);

  void removeTicket(Ticket ticket) => FirebaseApi.deleteTicket(ticket);
  void removeTicketById(String docId) => FirebaseApi.deleteTicketById(docId);

  bool toggleTicketStatus(Ticket ticket) {
    ticket.isDone = !ticket.isDone;
    FirebaseApi.updateTicket(ticket);

    return ticket.isDone;
  }

  void updateTicket(Ticket ticket, String name, String status) {
    ticket.name = name;
    ticket.status = status;

    FirebaseApi.updateTicket(ticket);
  }
}
