import 'package:admin/api/firebase_api.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:flutter/material.dart';

class TableUsersContextMenu extends StatelessWidget {
  const TableUsersContextMenu({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) async {},
      itemBuilder: (context) {
        return [
          PopupMenuItem<String>(
            value: 'Edit',
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit'),
              onTap: () async {
                Navigator.pop(context); // close Popup
                Navigator.pushNamed(context, '/profile',
                    arguments: ScreenArguments(
                        user: await FirebaseApi.readUser(uid: uid)));
              },
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                AlertDialog(
                  title: Text('Attention'),
                  content: Text('Delete User?'),
                  actions: [
                    TextButton(onPressed: () {}, child: Text('No')),
                    TextButton(onPressed: () {}, child: Text('Yes')),
                  ],
                );
              },
            ),
          ),
        ];
      },
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}
