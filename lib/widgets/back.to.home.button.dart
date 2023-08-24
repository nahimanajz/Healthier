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

FloatingActionButton buildFaButton(
    BuildContext context, void Function() onPressed, Widget child) {
  return FloatingActionButton(
      onPressed: onPressed, shape: const OvalBorder(), child: child);
}

Flexible buildSignButton(Function() onPressed, {String title = 'Signup'}) {
  return Flexible(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style:
            ElevatedButton.styleFrom(backgroundColor: lightColorScheme.primary),
        child: Text(
          title,
          style: TextStyle(color: lightColorScheme.surface),
        ),
      ),
    ),
  );
}
