import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/services/report.service.dart';

class CommentsTable extends StatelessWidget {
  //_CommentsTableState():_dataSource=FirestoreDataSource(context);
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.arrow_back_ios_rounded)),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: ReportService.getFeebackReports(
              endDate: args?["endDate"],
              startDate: args?["startDate"],
              phoneNumber: args?["phoneNumber"]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final dataList = snapshot.data!;

            return PaginatedDataTable(
              header: Text('Bits of feedbacks '),
              columns: [
                DataColumn(label: Text("Medicine")),
                DataColumn(label: Text("Text")),
                DataColumn(label: Text("Rate")),
              ],
              source: FirestoreDataTableSource(dataList),
              rowsPerPage: 5,
            );
          },
        ),
      ),
    );
  }
}

class FirestoreDataTableSource extends DataTableSource {
  FirestoreDataTableSource(this.dataList);

  final List<CommentModel> dataList;

  @override
  DataRow? getRow(int index) {
    if (index >= dataList.length) {
      return null;
    }

    final data = dataList[index];

    return DataRow(cells: [
      DataCell(Text(data.medicineName as String)),
      DataCell(Text(data.text as String)),
      DataCell(Text(data.rate as String)),
      // Add more DataCells for each column
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dataList.length;

  @override
  int get selectedRowCount => 0;
}
