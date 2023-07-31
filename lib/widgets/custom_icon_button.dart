import 'package:flutter/material.dart';

import '../utils/color_schemes.g.dart';

class CustomIconButton extends StatelessWidget {
  final String userType;
  final Widget icon;
  final void Function() onNavigateTo;

  const CustomIconButton(
      {super.key,
      required this.userType,
      required this.icon,
      required this.onNavigateTo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      onPressed: onNavigateTo,
      icon: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle, color: lightColorScheme.surface),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 2.0, 12.0, 0.0),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Text(
                  userType,
                  style:
                      const TextStyle(color: Color(0xFF046E00), fontSize: 16),
                ),
              )
            ],
          )),
    );
  }
}
