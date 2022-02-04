import 'package:admin/model/ticket_static.dart';
import 'package:admin/model/user.dart';
import 'package:admin/model/user_group/user_groups.dart';

class ScreenArguments {
  final String? ticketId;
  final Ticket? ticket;
  final User? user;
  final UserGroups? userGroups;

  ScreenArguments({this.ticketId, this.ticket, this.user, this.userGroups});
}