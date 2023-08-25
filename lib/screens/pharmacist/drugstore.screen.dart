import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthier2/models/drugstore.model.dart';
import 'package:healthier2/repositories/drugstore.repository.dart';
import 'package:healthier2/utils/color_schemes.g.dart';
import 'package:healthier2/utils/toast.dart';
import 'package:healthier2/widgets/custom_textFormField.dart';
import 'package:healthier2/widgets/styles/gradient.decoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrugStoreScreen extends StatefulWidget {
  const DrugStoreScreen({super.key});

  @override
  State<DrugStoreScreen> createState() => _DrugStoreScreenState();
}

class _DrugStoreScreenState extends State<DrugStoreScreen> {
  final _QuantityController = TextEditingController();
  final _medicineNameController = TextEditingController();

  onSaveDrug() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = await prefs.getString("signedInUserId");
      final drugStore = DrugStoreModel(
          medicineName: _medicineNameController.text,
          quantity: int.parse(_QuantityController.text),
          userId: userId);
      DrugStoreRepository.create(drugStore);
      showSuccessToast(context);
    } catch (e) {
      print(e);
      showErrorToast(context);
    }
  }

  onDelete(String documentId) async {
    await DrugStoreRepository.delete(documentId);
  }

  onUpdate() async {}

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final drug = args?["drugstore"] as DrugStoreModel?;
    final isEditing = args?["isEditing"] as bool?;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isEditing != null ? "Edit ${drug?.medicineName as String} " : " "),
        actions: [
          isEditing == null
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: lightColorScheme.secondary),
                )
              : IconButton(
                  onPressed: () {
                    onDelete(drug?.documentId as String);
                  },
                  icon: Icon(Icons.delete, color: lightColorScheme.primary),
                )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: lightColorScheme.primary),
        ),
        backgroundColor: lightColorScheme.secondary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: gradientDecoration,
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset('assets/images/clinic.svg'),
                ),
              ),
              buildNewDrugForm(),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isEditing as bool == true) {
                        onUpdate();
                      } else {
                        onSaveDrug();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: lightColorScheme.primary),
                    child: Text(
                      isEditing == null ? "Save" : "Update",
                      style: TextStyle(color: lightColorScheme.surface),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Flexible buildNewDrugForm() {
    return Flexible(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildTextFormField("Medicine Name", _medicineNameController),
            buildTextFormField("Quantity", _QuantityController,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
    );
  }
}
