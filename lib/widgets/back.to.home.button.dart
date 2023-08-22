import 'package:flutter/material.dart';

import '../utils/color_schemes.g.dart';

FloatingActionButton buildBackToHomeButton(BuildContext context) {
  return FloatingActionButton(
    backgroundColor: Colors.amber,
    onPressed: () {
      Navigator.pop(context);
    },
    child: Icon(
      Icons.arrow_back_ios,
      color: lightColorScheme.onPrimary,
    ),
  );
}
