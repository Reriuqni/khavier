import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Utils {
  // static void showSnackBar(BuildContext context, String text) =>
  //     Scaffold.of(context)
  //       ..removeCurrentSnackBar()
  //       ..showSnackBar(SnackBar(content: Text(text)));

  static DateTime? toDateTime(Timestamp? value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  // return Array of Tickets
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          // return 
          // [{priority: , body: , status: , date: Timestamp(seconds=1636668000, nanoseconds=0), subject: , id: id2, owner: , executorId: , tag: , name: 3, type: }, {tag: , executorId: ,status: , date: Timestamp(seconds=1637272800, nanoseconds=0), subject: , id: id1, name: 4, body: , priority: , owner: , type: }]
          final snaps = data.docs.map((doc) => doc.data()).toList();

          // return
          // [Instance of 'Ticket', Instance of 'Ticket']
          final objects = snaps.map((json) => fromJson(json as Map<String, dynamic>)).toList();

          sink.add(objects);
        },
      );
}
