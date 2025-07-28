import 'package:shift_handover_challenge/src/domain/model/model.dart';

abstract class ShiftReportRepository {
  Future<bool> submitShiftReport(ShiftReport report);

  Future<ShiftReport> getShiftReport(String caregiverId);
}
