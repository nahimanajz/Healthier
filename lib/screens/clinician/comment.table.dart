import 'package:flutter/material.dart';
import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/services/report.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/excel_report.service.dart';

class CommentsTable extends StatefulWidget {
  const CommentsTable({super.key});

  @override
  State<CommentsTable> createState() => _CommentsTableState();
}

class _CommentsTableState extends State<CommentsTable> {
  String? patientInfo;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    patientInfo = prefs.getString("patientInfo");
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios),
      )),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: ReportService.getFeebackReports(
              endDate: args?["endDate"],
              startDate: args?["startDate"],
              phoneNumber: args?["phoneNumber"],
              prescriptionId: args?["prescriptionId"]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final dataList = snapshot.data!;

            return PaginatedDataTable(
              actions: [
                ElevatedButton(
                  onPressed: () {
                    ExcelReportService.createCommentsReport(
                        dataList); //createObedienceReport(dataList);
                  },
                  child: const Icon(Icons.print),
                ),
              ],
              header: Text('Bits of feedback  ${patientInfo ?? " "} '),
              columns: const [
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
