import 'package:admin/api/firebase_api.dart';
import 'package:flutter/material.dart';

Future<String?> showDeleteDialog(BuildContext context, {required String uid}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Attention!'),
      content: Text('Are you sure to delete User?\nuid: $uid'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'OK');
            await FirebaseApi.deleteUserGroups(uid: uid);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
