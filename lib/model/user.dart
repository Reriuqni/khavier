import 'package:admin/model/baseClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Status.dart';

class NewUser extends BaseClass {
  String subject = '';
  String body = '';
  String priority = '';
  String executorId = '';
  List<String> executorHelpers = [];
  // List comments = [];
  List<Status> history = [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> baseObj = super.toMap();
    Map<String, dynamic> ticObj = {
      'subject': subject,
      'body': body,
      'priority': priority,
      'executorId': executorId,
    };

    ticObj.addAll(baseObj);

    return ticObj;
  }

  void fromMap(Map<String, dynamic> m) {
    super.fromMap(m);
    this.subject = m.containsKey('subject') ? m['subject'] : '';
    this.body = m.containsKey('body') ? m['body'] : '';
    this.priority = m.containsKey('priority') ? m['priority'] : '';
    this.executorId = m.containsKey('executorId') ? m['executorId'] : '';
  }


  void fromJsonQueryDocumentSnapshot(QueryDocumentSnapshot m) {
    // super.fromJsonQueryDocumentSnapshot(m);
    this.subject = m['subject'] == null ? '' : m['subject'];
    this.body = m['body'] == null ? '' : m['body'];
    this.priority = m['priority'] == null ? '' : m['priority'];
    this.executorId = m['executorId'] == null ? '' : m['executorId'];
  }
}
