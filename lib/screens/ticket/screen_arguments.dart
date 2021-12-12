import 'package:admin/model/ticket_static.dart';

class ScreenArguments {
  final String? ticketId;
  final Ticket? ticket;

  ScreenArguments({this.ticketId, this.ticket});
}