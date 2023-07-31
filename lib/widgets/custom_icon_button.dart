import 'package:flutter/material.dart';

import '../utils/color_schemes.g.dart';

class CustomIconButton extends StatelessWidget {
  final String userType;
  final Widget icon;
  final void Function() onNavigateTo;

  CustomIconButton(
      {required this.userType, required this.icon, required this.onNavigateTo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
      onPressed: () => {
        // TODO: handle navigation logic here
      },
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
                padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Text(
                  userType ?? " ",
                  style: TextStyle(color: Color(0xFF046E00), fontSize: 16),
                ),
              )
            ],
          )),
    );
  }
}
