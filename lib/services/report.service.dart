import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/models/obedience.model.dart';
import 'package:healthier2/repositories/comment.respository.dart';
import 'package:healthier2/repositories/obedience.repository.dart';

class ReportService {
  // 1. comments report, patient information report =>, patient Name,  temp,
  // comments, patientName, presciption, coment Text, obedience status
  // Report medicine obedience

  static Stream<List<CommentModel>> getFeebackReports(
      {String? startDate,
      String? endDate,
      String? phoneNumber,
      String? prescriptionId}) {
    return CommentRepository.getPatientComments(
        prescriptionId: prescriptionId as String,
        patientId: phoneNumber as String);
  }

  static Stream<List<ObedienceModel>> getObedience(
      {String? startDate,
      String? endDate,
      String? phoneNumber,
      String? prescriptionId}) {
    return ObedienceRepository.getObedience(
        patientId: phoneNumber as String,
        prescriptionId: prescriptionId as String);
  }
}
