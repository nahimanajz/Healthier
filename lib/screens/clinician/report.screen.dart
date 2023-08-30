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
  final startDateCtr = TextEditingController();
  final endDateCtr = TextEditingController();

  bool showFeedbackReport = false;

  @override
  void initState() {
    // TODO: implement initState
    startDateCtr.text = "";
    endDateCtr.text = "";
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
        TextField(
          controller: startDateCtr,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100));

            if (pickedDate != null) {
              setState(() {
                startDateCtr.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
          decoration: InputDecoration(
            icon: Icon(
              Icons.calendar_today,
              color: lightColorScheme.primary,
            ),
            border: const OutlineInputBorder(),
            hintText: 'Start date',
            labelText: "End date",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: endDateCtr,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2100));

            if (pickedDate != null) {
              setState(() {
                endDateCtr.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          },
          decoration: InputDecoration(
            icon: Icon(
              Icons.calendar_today,
              color: lightColorScheme.primary,
            ),
            border: const OutlineInputBorder(),
            hintText: 'EndDate date',
            labelText: "End date",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            if (startDateCtr.text.isEmpty ||
                endDateCtr.text.isEmpty ||
                prescriptionId.isEmpty) {
              showErroroast(context);
            } else {
              //get phone number

              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var phoneNumber = prefs.getString("reportedPhoneNumber");

              var arguments = {
                "startDate": startDateCtr.text,
                "endDate": endDateCtr.text,
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
