import 'package:admin/model/ticket_static.dart';
import 'package:admin/model/user.dart';

class ScreenArguments {
  final String? ticketId;
  final Ticket? ticket;
  final User? user;

  ScreenArguments({this.ticketId, this.ticket, this.user});
}