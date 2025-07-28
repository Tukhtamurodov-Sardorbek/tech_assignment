import 'dart:math' show Random;

import 'package:shift_handover_challenge/src/domain/model/model.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/shift_handover_usecases.dart';

final class UpdateReportImpl implements UpdateReport {
  @override
  ShiftReport addNote(ShiftReport report, String text, NoteType type) {
    final newNote = HandoverNote(
      text: text,
      type: type,
      timestamp: DateTime.now(),
      authorId: report.caregiverId,
      id: 'note-${Random().nextInt(1000)}',
    );

    final updatedNotes = List<HandoverNote>.from(report.notes)..add(newNote);

    final updatedReport = ShiftReport(
      id: report.id,
      notes: updatedNotes,
      startTime: report.startTime,
      caregiverId: report.caregiverId,
    );
    return updatedReport;
  }
}
