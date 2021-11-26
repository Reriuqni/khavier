import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(text)));

  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;
    // if (value.toString().isEmpty) return null;
    // if (value == '') return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );

  static StreamTransformer transformer2<T>(
      T Function(Map<String, dynamic> json) fromJson) {
        print('fromJson:');
        print(fromJson);
        print('-------------------------');
        
    return StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
        List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        print('data: ' + data.toString());
        print('sink: ' + sink.toString());
        final snaps = data.docs.map((doc) => doc.data()).toList();

        print('snaps: ' + snaps.toString());
        
        print('snaps forEach:');
        snaps.forEach((e) { print(e);});

        print('');
        print('snaps map:');
        snaps.map((json) => print('json: ' + json));
        

        print('');
        print('snaps map toList:');
        print(snaps.map((json) => fromJson(json)).toList());

        print('snaps end:');
        // final objects = snaps.map((json) => fromJson(json)).toList();
        // sink.add(objects);
      },
    );
  }
}
