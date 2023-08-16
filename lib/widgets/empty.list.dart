import 'package:flutter/material.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';

import '../utils/color_schemes.g.dart';

Widget buildEmptyList({String title = "No records yet"}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 60,
          color: lightColorScheme.primary,
        ),
        KTextStyle(text: title, color: lightColorScheme.primary, size: 14)
      ],
    ),
  );
}
