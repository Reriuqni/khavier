import 'package:flutter/cupertino.dart';
import 'package:admin/utils.dart';

class TicketField {
  static const date = 'date';
}

class Ticket {
  DateTime date;
  String name;
  String status;
  String type;
  String id;
  String owner;
  String body;
  bool isDone;

  Ticket({
    @required this.date,
    @required this.name,
    this.status = '',
    this.type = '',
    this.id = '',
    this.owner = '',
    this.body = '',
    this.isDone = false,
  });

  static Ticket fromJson(Map<String, dynamic> json) => Ticket(
        date: Utils.toDateTime(json['date']),
        name: json['name'],
        status: json['status'],
        type: json['type'],
        id: json['id'],
        owner: json['owner'],
        body: json['body'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'date': Utils.fromDateTimeToJson(date),
        'name': name,
        'status': status,
        'type': type,
        'id': id,
        'owner': owner,
        'body': body,
        'isDone': isDone,
      };
}
