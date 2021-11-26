import 'dart:js';

import 'package:admin/constants.dart';
import 'package:admin/model/model.dart';
import 'package:admin/model/ticket.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({Key key}) : super(key: key);
  static const routeName = '/extractArguments';

  @override
  State<AddTicket> createState() => _AddTicket();
}

class _AddTicket extends State<AddTicket> with RestorationMixin {
  final RestorableIntN _indexSelected = RestorableIntN(null);

  @override
  String get restorationId => 'choice_chip_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_indexSelected, 'choice_chip');
  }

  @override
  void dispose() {
    _indexSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Model model = Provider.of<Model>(context);
    bool isShowLoading = false;
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    dynamic args;
    Ticket _ticket = Ticket();
    String titleOfPage = 'Add Ticket ModalRoute';
    String dropdownValue = 'One';

    args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      args = args as ScreenArguments;
      // _ticket = args.ticket ?? Ticket();
      if (args.ticketId != null) {
        titleOfPage = 'Edit Ticket ModalRoute';
        String id = args.ticketId ?? '';
        _ticket = model.db.getTicketById(id);
        // _ticket.id = args.ticketId ?? '';
      }
    }

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
                      titleOfPage + ' ' + _ticket.id,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'Owner: ' + _ticket.owner,
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
                          // selected: _indexSelected.value == 0,
                          selected: _ticket.status == 'Blocker',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 0 : -1;
                              _ticket.status = 'Blocker';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Critical'),
                          // selected: _indexSelected.value == 1,
                          selected: _ticket.status == 'Critical',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 1 : -1;
                              _ticket.status = 'Critical';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Medium'),
                          // selected: _indexSelected.value == 2,
                          selected: _ticket.status == 'Medium',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 2 : -1;
                              _ticket.status = 'Medium';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Low'),
                          // selected: _indexSelected.value == 3,
                          selected: _ticket.status == 'Low',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 3 : -1;
                              _ticket.status = 'Low';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          selectedColor: Colors.indigo.withOpacity(0.5),
                          disabledColor: Colors.indigo.withOpacity(0.6),
                          labelStyle: TextStyle(color: Colors.black54),
                          label: Text('Idea'),
                          // selected: _indexSelected.value == 4,
                          selected: _ticket.status == 'Idea',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 4 : -1;
                              _ticket.status = 'Idea';
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
                          labelText: _ticket.name,
                          hintText: 'Title of ticket',
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
                        onChanged: (title) {
                          _ticket.name = title;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        _ticket.body,
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
                              // labelText: 'Description1',
                              labelText: _ticket.body,
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
                            onChanged: (body) {
                              _ticket.body = body;
                            },
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        'Type:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: _ticket.type,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          _ticket.type = newValue;
                        });
                      },
                      items: <String>[
                        '',
                        'Need',
                        'Maybe',
                        'Whatelse',
                        'Forgoted'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            padding: EdgeInsets.fromLTRB(25, 10, 25, 10)),
                        onPressed: () {
                          print('Save Ticket');
                          setState(() {
                            isShowLoading = true;
                          });

                          model.db.addTicket(_ticket).whenComplete(() {
                            model.db.getTickets();
                            Navigator.pop(context);
                          });

                          // Navigator.pop(context);
                          // setState(() {});
                        },
                        child: isShowLoading ? CircularProgressIndicator() : Text('Sumbit'))
                  ]),
              // Column(
              //   children: [
              //     Container(
              //         margin: EdgeInsets.fromLTRB(30, 50, 15, 30),
              //         width: 700,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Documents:',
              //               style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             ElevatedButton.icon(
              //                 style: ElevatedButton.styleFrom(
              //                     primary: primaryColor,
              //                     padding: EdgeInsets.fromLTRB(25, 10, 25, 10)),
              //                 onPressed: () => {},
              //                 icon: Icon(Icons.add),
              //                 label: Text('Add'))
              //           ],
              //         )),
              //   ],
              // ),
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
