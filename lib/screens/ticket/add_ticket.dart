// import 'dart:js';

import 'package:admin/constants.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
// import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:provider/provider.dart';

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

  bool isShowLoading = false;
  dynamic args;

  Ticket? _ticket = Ticket(
    id: DateTime.now().toString(),
    name: '',
    date: DateTime.now(),
  );
  String titleOfPage = 'Add Ticket ModalRoute';
  bool isAddTicket = true;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      args = args as ScreenArguments?;
      if (args.ticket != null) {
        titleOfPage = 'Edit Ticket ModalRoute';
        _ticket = args.ticket;
        isAddTicket = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: primaryColor,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: iconColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleOfPage + ' ' + _ticket!.id!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    SizedBox(height: 15,),
                    Text(
                        'Owner: ' + _ticket!.owner!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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
                        OwnChoiceChip(
                          label: 'Blocker',
                          selected: _ticket!.status == 'Blocker',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 0 : -1;
                              _ticket!.status = 'Blocker';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        OwnChoiceChip(
                          label: 'Critical',
                          selected: _ticket!.status == 'Critical',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 1 : -1;
                              _ticket!.status = 'Critical';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        OwnChoiceChip(
                          label: 'Medium',
                          selected: _ticket!.status == 'Medium',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 2 : -1;
                              _ticket!.status = 'Medium';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        OwnChoiceChip(
                          label: 'Low',
                          selected: _ticket!.status == 'Low',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 3 : -1;
                              _ticket!.status = 'Low';
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        OwnChoiceChip(
                          label: 'Idea',
                          selected: _ticket!.status == 'Idea',
                          onSelected: (value) {
                            setState(() {
                              _indexSelected.value = value ? 4 : -1;
                              _ticket!.status = 'Idea';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text(
                        'Name:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: 700,
                      child: OwnTextField(
                          labelText: 'Name: ' + _ticket!.name!,
                          hintText: 'Title of ticket',
                        initialValue: _ticket!.name,
                        onChanged: (body) {
                          _ticket!.name = body;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        // _ticket.body,
                        'Body:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                          width: 700,
                        child: OwnBigTextField(
                            initialValue: _ticket!.body,
                              labelText: 'Body',
                              hintText: 'Description',
                            onChanged: (body) {
                              _ticket!.body = body;
                            },
                        )
                          ),
                    SizedBox(height: 15),
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
                      value: _ticket!.type,
                      // value: _type,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          // _type = newValue;
                          _ticket!.type = newValue;
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
                    OwnButton(
                      label: 'Sumbit',
                        onPressed: () {
                          final provider = Provider.of<TicketsProvider>(context,
                              listen: false);

                          if (isAddTicket) {
                            provider.addTicket(_ticket!);
                          } else {
                            provider.updateTicket(_ticket!);
                          }

                          Navigator.pop(context);
                        },
                    ),
                    // ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //         primary: primaryColor,
                    //         padding: EdgeInsets.fromLTRB(25, 10, 25, 10)),
                    //     onPressed: () {
                    //       final provider = Provider.of<TicketsProvider>(context,
                    //           listen: false);
                    //
                    //       if (isAddTicket) {
                    //         provider.addTicket(_ticket);
                    //       } else {
                    //         provider.updateTicket(_ticket);
                    //       }
                    //
                    //       Navigator.pop(context);
                    //     },
                    //     child: isShowLoading
                    //         ? CircularProgressIndicator()
                    //         : Text('Sumbit'))
                  ]),
            ],
          ),
        ),
      ),
      )
    );
  }
}
