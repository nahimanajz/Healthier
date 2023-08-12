import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

import '../utils/color_schemes.g.dart';

TextFormField buildTextFormField(String title, TextEditingController controller,
    {TextInputType? keyboardType = TextInputType.text}) {
  return TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    decoration: InputDecoration(
      filled: true,
      fillColor: lightColorScheme.background,
      labelText: title,
      labelStyle: TextStyle(
          color: lightColorScheme.scrim,
          fontSize: 14,
          decorationColor: lightColorScheme.scrim),
    ),
  );
}

SelectFormField buildSelectFormField(
    TextEditingController controller, var items,
    {required String labelText,
    required String dialogTitle,
    required String searchHint}) {
  return SelectFormField(
    controller: controller,
    enableSearch: true,
    type: SelectFormFieldType.dialog,
    labelText: labelText,
    changeIcon: true,
    dialogCancelBtn: 'Cancel',
    dialogTitle: dialogTitle,
    dialogSearchHint: searchHint,
    items: items,
    decoration: InputDecoration(
      suffixIcon: const Icon(Icons.arrow_drop_down),
      filled: true,
      fillColor: lightColorScheme.background,
      labelStyle: TextStyle(
          color: lightColorScheme.scrim,
          fontSize: 14,
          decorationColor: lightColorScheme.scrim),
    ),
    onChanged: (value) async {
      // double temp = await CountryService.getTemperature(city: value);
      // if (temp) {
      //   temp = await CountryService.getTemperature();
      // }
    },
  );
}
