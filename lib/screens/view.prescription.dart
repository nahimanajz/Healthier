import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/color_schemes.g.dart';
import '../widgets/styles/KTextStyle.dart';

enum UserType { patient, clinician, pharmacist }

class ViewPrescriptionScreen extends StatefulWidget {
  // TODO: Loop List of prescription medicines
  const ViewPrescriptionScreen({super.key});

  @override
  State<ViewPrescriptionScreen> createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            //TODO: this back works after implementing navigations
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: lightColorScheme.primary,
      ),
      body: SafeArea(
          child: Container(
        color: lightColorScheme.primary,
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
        child: ListView(
          children: [
            Flexible(
              flex: 1,
              //TODO: put every state value at appropriate location in below long text
              child: Container(
                child: KTextStyle(
                  text: 'Your prescription for [IllNess]',
                  color: lightColorScheme.surface,
                  fontWeight: FontWeight.w700,
                  size: 20.0,
                ),
              ),
            ),
            //TODO: loop from list of prescriptions
            buildPresciptionItem(
                description:
                    '1 Tablet everyday for 1 week in morning, noon after food',
                title: 'Aspirin'),
          ],
        ),
      )),
    );
  }

  Flexible buildPresciptionItem(
      {required String title, required String description}) {
    return Flexible(
      child: Card(
        color: lightColorScheme.onPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: FaIcon(FontAwesomeIcons.pills),
              title: KTextStyle(
                text: title,
                color: lightColorScheme.scrim,
                fontWeight: FontWeight.bold,
                size: 20.0,
              ),
              subtitle: KTextStyle(
                text: description,
                color: lightColorScheme.scrim,
                size: 14.0,
              ),
              iconColor: lightColorScheme.primary,
            ),
            //TODO: if is patient show provide feedback button,elseif user== pharmacist show approve availability
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: lightColorScheme.onPrimary,
              ),
              child: KTextStyle(
                text: 'Approve availability',
                color: lightColorScheme.primary,
                size: 14.0,
              ),
            ),
            /*
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: lightColorScheme.onPrimary,
              ),
              child: KTextStyle(
                text: 'Provide Feedback',
                color: lightColorScheme.primary,
                size: 14.0,
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
