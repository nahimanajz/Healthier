import 'package:flutter/material.dart';

class KTextStyle extends StatelessWidget {
  final String text;

  final Color color;
  final FontWeight? fontWeight;
  final double size;

  const KTextStyle(
      {super.key,
      required this.text,
      required this.color,
      this.fontWeight,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          fontFamily: 'Roboto'),
    );
  }
}
