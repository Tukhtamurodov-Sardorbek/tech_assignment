import 'package:shift_handover_challenge/src/domain/model/model.dart';

abstract class SubmitShiftReport {
  Future<ShiftReport?> submit(ShiftReport report, String summary);
}

abstract class GetShiftReport {
  Future<ShiftReport> get(String caregiverId);
}

abstract class UpdateReport{
  ShiftReport addNote(ShiftReport report, String text, NoteType type);
}