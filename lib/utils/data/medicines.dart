import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<Map<String, dynamic>> medicines = [
  {
    'value': 'Tablet',
    'label': 'Tablet',
    'icon': const FaIcon(FontAwesomeIcons.pills)
  },
  {
    'value': 'Liquid',
    'label': 'Liquid',
    'icon': Icon(Icons.medication_liquid_outlined),
  },
  {
    'value': 'Drops',
    'label': 'Drops',
    'icon': const FaIcon(FontAwesomeIcons.droplet)
  }
];
