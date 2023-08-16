import 'package:healthier2/models/comment.model.dart';
import 'package:healthier2/repositories/comment.respository.dart';

class ReportService {
  // 1. comments report, patient information report =>, patient Name,  temp,
  // comments, patientName, presciption, coment Text, obedience status
  // Report medicine obedience

  static Stream<List<CommentModel>> getFeebackReports(
      {String? startDate, String? endDate, String? phoneNumber}) {
    return CommentRepository.getPatientComments(
        patientId: phoneNumber as String);
  }
}
