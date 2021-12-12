import 'package:admin/model/ticket.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RecenttTickets extends StatelessWidget {
  const RecenttTickets({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Tickets",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: DataTable2(
          //     columnSpacing: defaultPadding,
          //     minWidth: 600,
          //     columns: [
          //       DataColumn(
          //         label: Text("ID"),
          //       ),
          //       DataColumn(
          //         label: Text("Name"),
          //       ),
          //       DataColumn(
          //         label: Text("Priority"),
          //       ),
          //       DataColumn(
          //         label: Text("Type"),
          //       ),
          //       DataColumn(
          //         label: Text("Date"),
          //       ),
          //     ],
          //     rows: List.generate(
          //       demoRecentFiles.length,
          //       (index) { recentTicketDataRow(tickets[index])},
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

DataRow recentTicketDataRow(Ticket ticket) {
  return DataRow(
    cells: [
      DataCell(Text(ticket.id!)),
      DataCell(Text(ticket.name!)),
      DataCell(Text(ticket.priority!)),
      DataCell(Text(ticket.type!)),
      DataCell(Text(ticket.date!)),
    ],
  );
}
