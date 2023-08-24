import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/data/medicines.dart';
import 'package:healthier2/widgets/back.to.home.button.dart';
import 'package:healthier2/widgets/custom_textFormField.dart';
import 'package:healthier2/widgets/styles/KTextStyle.dart';

class StockMedicine extends StatefulWidget {
  const StockMedicine({super.key});

  @override
  State<StockMedicine> createState() => _StockMedicineState();
}

class _StockMedicineState extends State<StockMedicine> {
  final _typeController = TextEditingController();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock medicine"),
      ),
      body: ElevatedButton(
          onPressed: () {
            _showFullModal(context);
          },
          child: KTextStyle(
              color: lightColorScheme.primary, text: "New medicine", size: 16)),
    );
  }

  _showFullModal(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: lightColorScheme.scrim,
                    width: 1,
                  ),
                ),
              ),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColorScheme.primary,
                          shape: StadiumBorder(
                            side: BorderSide(color: lightColorScheme.primary),
                          ),
                        ),
                        child: KTextStyle(
                          text: "Add Medicine",
                          color: lightColorScheme.onPrimary,
                          size: 14.0,
                        ),
                      )
                    ],
                  ),
                  buildTextFormField("Medicine Name", _nameController),
                  buildTextFormField("Quantity", _quantityController),
                  buildSelectFormField(
                    _typeController,
                    medicines,
                    labelText: 'Medicine Type',
                    dialogTitle: ' Medicine type',
                    searchHint: 'Search medicine',
                  ),
                  buildSignButton(() {
                    // TODO: save new medicine to the database
                  }, title: "Append to stock"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
