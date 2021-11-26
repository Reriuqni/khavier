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
  bool isDone;

  Ticket({
    @required this.date,
    @required this.name,
    this.status = '',
    this.type = '',
    // this.id,
    this.id = '',
    this.isDone = false,
  });

  static Ticket fromJson(Map<String, dynamic> json) => Ticket(
        date: Utils.toDateTime(json['date']),
        name: json['name'],
        status: json['status'],
        type: json['type'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'date': Utils.fromDateTimeToJson(date),
        'name': name,
        'status': status,
        'type': type,
        'id': id,
        'isDone': isDone,
      };
}
