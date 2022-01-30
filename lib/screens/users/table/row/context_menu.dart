import 'package:admin/api/firebase_api.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:admin/screens/users/table/row/delete_dialog.dart';
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
                    arguments: ScreenArguments(user: await FirebaseApi.readUser(uid: uid)));
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
                showDeleteDialog(context, uid: uid);
              },
            ),
          ),
        ];
      },
    );
  }
}
