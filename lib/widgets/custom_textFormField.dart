import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:select_form_field/select_form_field.dart';

import '../utils/color_schemes.g.dart';
import '../utils/firebase.instance.dart';

InputDecoration kInputDecoration(String title) {
  return InputDecoration(
    filled: true,
    fillColor: lightColorScheme.background,
    labelText: title,
    labelStyle: TextStyle(
        color: lightColorScheme.scrim,
        fontSize: 14,
        decorationColor: lightColorScheme.scrim),
  );
}

TextFormField buildTextFormField(String title, TextEditingController controller,
    {TextInputType? keyboardType = TextInputType.text,
    bool isHidden = false,
    Function(String)? onChanged}) {
  return TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    onChanged: onChanged,
    obscureText: isHidden,
    decoration: kInputDecoration(title),
  );
}

TextFormField buildPhoneField(TextEditingController controller) {
  return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      keyboardType: TextInputType.phone,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty || value.length != 10) {
          return 'Phone must be 10 digits';
        }
        return null;
      },
      decoration: kInputDecoration("Phone Number"));
}

SelectFormField buildSelectFormField(
    TextEditingController controller, var items,
    {required String labelText,
    required String dialogTitle,
    required String searchHint,
    Function(String)? onChanged}) {
  return SelectFormField(
    controller: controller,
    enableSearch: true,
    type: SelectFormFieldType.dialog,
    labelText: labelText,
    changeIcon: true,
    dialogCancelBtn: 'Cancel',
    dialogTitle: dialogTitle,
    dialogSearchHint: searchHint,
    items: items,
    decoration: InputDecoration(
      suffixIcon: const Icon(Icons.arrow_drop_down),
      filled: true,
      fillColor: lightColorScheme.background,
      labelStyle: TextStyle(
          color: lightColorScheme.scrim,
          fontSize: 14,
          decorationColor: lightColorScheme.scrim),
    ),
    onChanged: onChanged,
  );
}

StreamBuilder<QuerySnapshot<Object?>> buildMedicineStreamBuilder(
    {required void Function(String?) onChanged}) {
  final CollectionReference drugstoresCollection = db.collection('drugstores');
  return StreamBuilder<QuerySnapshot>(
    stream: drugstoresCollection.snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }

      final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
      final List<String> medicineNames =
          documents.map((doc) => doc['medicineName'] as String).toList();

      return FormBuilderDropdown(
        onChanged: onChanged,
        name: 'medicineName',
        decoration: InputDecoration(
          labelText: "Select medicine",
          filled: true,
          fillColor: lightColorScheme.background,
          labelStyle: TextStyle(
              color: lightColorScheme.scrim,
              fontSize: 14,
              decorationColor: lightColorScheme.scrim),
        ),
        items: medicineNames
            .map((name) => DropdownMenuItem(
                  value: name,
                  child: Text(name),
                ))
            .toList(),
      );
    },
  );
}
