import 'package:flutter/material.dart';
import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/services/report.service.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:intl/intl.dart';

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
  ReportType? _report = ReportType.feedback;
  final startDateCtr = TextEditingController();
  final endDateCtr = TextEditingController();
  final patientIdCtr = TextEditingController();

  final _reportService = ReportService();
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
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("Reports"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: buildForm(context),
          ),
        ),
      ),
    );
  }

  Column buildForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text("Feedback"),
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
          title: Text("Obedience"),
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
            border: OutlineInputBorder(),
            hintText: 'Start date',
            labelText: "End date",
          ),
        ),
        SizedBox(
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
            border: OutlineInputBorder(),
            hintText: 'EndDate date',
            labelText: "End date",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          controller: patientIdCtr,
          decoration: InputDecoration(
            icon: Icon(
              Icons.phone_android_outlined,
              color: lightColorScheme.primary,
            ),
            border: OutlineInputBorder(),
            hintText: ' Phone',
            labelText: "Phone Number ",
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () async {
            //TODO: get data and transform them into report
            // Todo: search for how you can call this person to data and passthem in parameters too.

            Navigator.pushNamed(context, "/comments/table", arguments: {
              "startDate": startDateCtr.text,
              "endDate": endDateCtr.text,
              "phoneNumber": patientIdCtr.text
            });
          },
          icon: Icon(
            // <-- Icon
            Icons.picture_as_pdf,
            size: 24.0,
          ),
          label: Text('Get it'), //
        ),
      ],
    );
  }
}
