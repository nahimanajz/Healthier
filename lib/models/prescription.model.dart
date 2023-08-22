import 'comment.model.dart';
import 'obedience.model.dart';

class PrescriptionModel {
  late final String description;
  late final bool isMedicineAvailable;
  late final String medicineName;
  late final String medicineType;
  late final List<CommentModel>? comments;
  late final List<ObedienceModel>? obedience;
}
