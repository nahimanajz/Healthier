import 'package:healthier2/helpers/main.helper.dart';
import 'package:healthier2/models/drugstore.model.dart';
import 'package:healthier2/repositories/drugstore.repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PrescriptionService {
  static Future<void> approveMedicine(
      {required String medQuantity, required String medicineName}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final pharmacyId = prefs.getString("signedInUserId");

      int reducableQuantity = extractAmount(medQuantity);

      DrugStoreModel drug =
          await DrugStoreRepository.getByPharmacyIdAndDrugName(
              medicineName: medicineName,
              pharmacyId: pharmacyId as String) as DrugStoreModel;
      int stockQuantity = drug.quantity as int;

      if (drug == null || stockQuantity < reducableQuantity) {
        throw Exception("Oops, you no longer have this medicine in your stock");
      }

      drug.quantity = stockQuantity - reducableQuantity;
      await DrugStoreRepository.update(drug);
    } catch (e) {
      throw Exception("You must be having low stock $e");
    }
  }
}
