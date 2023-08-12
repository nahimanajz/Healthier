import 'package:flutter/material.dart';

import '../../utils/color_schemes.g.dart';

var gradientDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightColorScheme.secondaryContainer, lightColorScheme.surface],
  ),
);
