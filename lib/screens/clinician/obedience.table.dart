import 'package:flutter/material.dart';
import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/services/report.service.dart';

class ObedienceTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: ReportService.getObedience(
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
              header: Text('Obedience '),
              columns: [
                DataColumn(label: Text("date")),
                DataColumn(label: Text("status")),
                DataColumn(label: Text("medicine")),
                DataColumn(label: Text("period")),
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

  final List<ObedienceModel> dataList;

  @override
  DataRow? getRow(int index) {
    if (index >= dataList.length) {
      return null;
    }

    final data = dataList[index];

    return DataRow(cells: [
      DataCell(Text(data.date as String)),
      DataCell(Text(data.status as String)),
      DataCell(Text(data.medicineName as String)),
      DataCell(Text(data.period as String))
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
