import 'package:flutter/material.dart';

class TableUsersContextMenu extends StatelessWidget {
  const TableUsersContextMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) async {
        switch (value) {
          case 'Export file':
            print('Export');
            _showSnackBar(
              context,
              'Export file',
            );
            break;

          case 'Delete':
            print('Delete');
            _showSnackBar(
              context,
              'Delete file',
            );
            break;

          default:
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text('Export file'),
            value: 'Export file',
          ),
          const PopupMenuItem(
            child: Text('Delete'),
            value: 'Delete',
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'Delete',
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: Text('Delete'),
              // iconColor: Colors.redAccent[400],
              hoverColor: Colors.redAccent[900],
            ),
          ),
        ];
      },
    );
  }

  void _showSnackBar(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data),
      ),
    );
  }
}
