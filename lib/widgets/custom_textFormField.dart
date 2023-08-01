import 'package:flutter/material.dart';

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
