import 'package:admin/constants.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard/components/header.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({Key? key}) : super(key: key);
  static const routeName = '/extractArguments';

  @override
  State<AddTicket> createState() => _AddTicket();
}

class _AddTicket extends State<AddTicket> with RestorationMixin {
  final RestorableIntN _indexSelected = RestorableIntN(null);

  @override
  String get restorationId => 'choice_chip_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_indexSelected, 'choice_chip');
  }

  @override
  void dispose() {
    _indexSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    print('Add Ticket ModalRoute');

    print(args);
    print(args.title);
    print(args.message);
    if (args.ticket != null) print(args.ticket);
    if (args.ticket != null) print(args.ticket.id);

    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      'Add New Ticket: ' + args.ticket.id,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'Owner: Owner: ' + args.ticket.owner,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        'Status:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Blocker'),
                          selected: _indexSelected.value == 0,
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 0 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Critical'),
                          selected: _indexSelected.value == 1,
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 1 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Medium'),
                          selected: _indexSelected.value == 2,
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 2 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Low'),
                          selected: _indexSelected.value == 3,
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 3 : -1;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Idea'),
                          selected: _indexSelected.value == 4,
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 4 : -1;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'Title:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: 700,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: args.ticket.name,
                          hintText: 'Print title',
                          labelStyle: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.black54, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.black54, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        args.ticket.body,
                        // 'Description:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Container(
                          width: 700,
                          child: TextFormField(
                            maxLines: 6,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: 'Description',
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                    color: Colors.black54, width: 2.0),
                              ),
                            ),
                          ),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.fromLTRB(25, 10, 25, 10)),
                        onPressed: () => {},
                        child: Text('Sumbit'))
                  ]),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(30, 50, 15, 30),
                      width: 700,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Documents:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10)),
                              onPressed: () => {},
                              icon: Icon(Icons.add),
                              label: Text('Add'))
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
