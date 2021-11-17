import 'package:admin/model/ticket.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  // late Model model;
  // late Future<List<Ticket>> tickets;

  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  void initState() {}

  // Future<List<Ticket>> getTickets() async {
  //   return await model.db.getTickets();
  // }

  @override
  Widget build(BuildContext context) {
    // tickets = getTickets();

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
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("ID"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Priority"),
                ),
                DataColumn(
                  label: Text("Type"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
                // (index) { recentTicketDataRow(tickets[index])},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}

DataRow recentTicketDataRow(Ticket ticket) {
  return DataRow(
    cells: [
      // DataCell(
      //   Row(
      //     children: [
      //       SvgPicture.asset(
      //         fileInfo.icon!,
      //         height: 30,
      //         width: 30,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(fileInfo.title!),
      //       ),
      //     ],
      //   ),
      // ),
      DataCell(Text(ticket.id)),
      DataCell(Text(ticket.name)),
      DataCell(Text(ticket.priority)),
      DataCell(Text(ticket.type)),
      DataCell(Text(ticket.date)),
    ],
  );
}
