import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/widgets/containers.dart';
import 'package:flutter/material.dart';

class UserGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SafeArea(
            child: HeaderAndSideMenu(
          widget: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('userGroups').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return buildText('Something Went Wrong Try later');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      Row(children: [ListTile(title: Text((snapshot.data!.docs[index].data()! as Map<String, dynamic>)['name']))]),
                );

                /// OR
                // return ListView.builder(
                //   itemCount: snapshot.data!.docs.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                //     return ListTile(
                //       title: Text(data['name']),
                //     );
                //   },
                // );

                /// OR
                // return ListView(
                //   children: snapshot.data!.docs
                //       .map((DocumentSnapshot document) => ListTile(
                //             title: Text((document.data()! as Map<String, dynamic>)['name']),
                //           ))
                //       .toList(),
                // );

                /// OR
                // return ListView(
                //   // shrinkWrap: true,
                //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
                //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                //     return ListTile(
                //       title: Text((document.data()! as Map<String, dynamic>)['name']),
                //       // title: Text(data['name']),
                //     );
                //   }).toList(),
                // );
              }),
        )));
  }
}

Widget buildText(String text) => Center(child: Text(text, style: TextStyle(fontSize: 24, color: Colors.blue)));
