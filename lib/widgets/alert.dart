
import 'package:flutter/widgets.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool?> showAlert(
  BuildContext context, {
  String title = "Success",
  String desc = "Your feedback is sent to clinician.",
  AlertType type = AlertType.success,
}) {
  return Alert(
    type: type,
    context: context,
    title: title,
    desc: desc,
    style: AlertStyle(
        animationType: AnimationType.fromBottom,
        animationDuration: const Duration(milliseconds: 400),
        overlayColor: const Color.fromARGB(143, 207, 203, 169),
        backgroundColor: lightColorScheme.onPrimary),
  ).show();
}
