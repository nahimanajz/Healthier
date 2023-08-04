import 'package:flutter/material.dart';
import 'package:healthier/widgets/styles/KTextStyle.dart';

import '../utils/color_schemes.g.dart';

class PrescriptionItem extends StatelessWidget {
  const PrescriptionItem({
    super.key,
  });
  onNavigate(String id) {
    //TODO: Navigate to prescription detail
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: lightColorScheme.surface,
        border: const Border(
          bottom: BorderSide(width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KTextStyle(
              text: "Prescription for fever",
              color: lightColorScheme.scrim,
              size: 14),
          IconButton(
              onPressed: onNavigate("example id"),
              icon: Icon(Icons.info, color: lightColorScheme.surfaceTint))
        ],
      ),
    );
  }
}
