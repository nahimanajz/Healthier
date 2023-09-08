import 'dart:io';

import 'package:healthier2/models/comment.model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../models/obedience.model.dart';

class ExcelReportService {
  static void createObedienceReport(List<ObedienceModel> obediences) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    // columns
    sheet.getRangeByName("A1").setText("date");
    sheet.getRangeByName("B1").setText("Medicine Name");
    sheet.getRangeByName("C1").setText("Period");
    sheet.getRangeByName("D1").setText("Status");

    for (int i = 0; i < obediences.length; i++) {
      final ObedienceModel obedience = obediences[i];
      final int rowIndex = i + 2;
      sheet.getRangeByName('A$rowIndex').setText(obedience.date as String);
      sheet
          .getRangeByName('B$rowIndex')
          .setText(obedience.medicineName as String);
      sheet.getRangeByName('C$rowIndex').setText(obedience.period as String);
      sheet.getRangeByName('D$rowIndex').setText(obedience.status as String);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/obediences.xlsx';
    final file = File(fileName);

    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  static void createCommentsReport(List<CommentModel> comments) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    // columns
    sheet.getRangeByName("A1").setText("Medicine Name");
    sheet.getRangeByName("B1").setText("Comment");
    sheet.getRangeByName("C1").setText("rate");

    for (int i = 0; i < comments.length; i++) {
      final CommentModel comment = comments[i];
      final int rowIndex = i + 2;
      sheet
          .getRangeByName('A$rowIndex')
          .setText(comment.medicineName as String);
      sheet
          .getRangeByName('B$rowIndex')
          .setText(comment.medicineName as String);
      sheet.getRangeByName('C$rowIndex').setText(comment.text as String);
      sheet.getRangeByName('D$rowIndex').setText("${comment.rate as String} %");
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/comments.xlsx';
    final file = File(fileName);

    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}
