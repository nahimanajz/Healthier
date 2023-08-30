import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Inner list which contains Data i.e Row

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            createExcel();
          },
          child: Text("Get Excel"),
        ),
      ),
    );
  }

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final file = File(fileName);

    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}
