import 'package:flutter/material.dart';
import 'package:healthier2/services/report.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ReportType {
  feedback,
  obedience,
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportType? _report;

  bool showFeedbackReport = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String prescriptionId = args?['prescriptionId'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Reports"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: buildForm(context, prescriptionId),
          ),
        ),
      ),
    );
  }

  Column buildForm(BuildContext context, String prescriptionId) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: const Text("Feedback"),
          leading: Radio<ReportType>(
              value: ReportType.feedback,
              groupValue: _report,
              onChanged: (ReportType? value) {
                setState(() {
                  _report = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Obedience"),
          leading: Radio<ReportType>(
              value: ReportType.obedience,
              groupValue: _report,
              onChanged: (ReportType? value) {
                setState(() {
                  _report = value;
                });
              }),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            if (prescriptionId.isEmpty) {
              showErroroast(context);
            } else {
              //get phone number

              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var phoneNumber = prefs.getString("reportedPhoneNumber");

              var arguments = {
                "phoneNumber": phoneNumber as String,
                "prescriptionId": prescriptionId
              };

              if (_report == ReportType.feedback) {
                Navigator.pushNamed(context, "/comments/table",
                    arguments: arguments);
              } else {
                Navigator.pushNamed(context, "/obedience/table",
                    arguments: arguments);
              }
            }
          },
          icon: const Icon(
            // <-- Icon
            Icons.picture_as_pdf,
            size: 24.0,
          ),
          label: const Text('Get it'), //
        ),
      ],
    );
  }
}
