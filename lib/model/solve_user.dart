
import 'package:admin/routes/roles.dart';

class SolveUser {
  String body;
  String date;
  String executorId;
  String id;
  String name;
  String owner;
  String priority;
  String status;
  String subject;
  String tag;
  String type;
  Roles role;

  SolveUser({
    this.body = '',
    this.date = '',
    this.executorId = '',
    required this.id,
    this.name = '',
    this.owner = '',
    this.priority = '',
    this.status = '',
    this.subject = '',
    this.tag = '',
    this.type = '',
    this.role = Roles.ROLE_NOT_FOUND,
  });

  Map<String, dynamic> tyJson() => {
        'body': body,
        'date': date,
        'executorId': executorId,
        'id': id,
        'name': name,
        'owner': owner,
        'priority': priority,
        'status': status,
        'subject': subject,
        'tag': tag,
        'type': type,
        'role': role.name,
      };

  static SolveUser fromJson(Map<String, dynamic> json) => SolveUser(
        body: json['body'],
        date: json['date'],
        executorId: json['executorId'],
        id: json['id'],
        name: json['name'],
        owner: json['owner'],
        priority: json['priority'],
        status: json['status'],
        subject: json['subject'],
        tag: json['tag'],
        type: json['type'],
        role: Roles.values.firstWhere((e) => e.name == json['role'], orElse: () => Roles.ROLE_NOT_FOUND),
      );
}
