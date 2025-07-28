import 'dart:math' show Random;

import 'package:flutter/cupertino.dart';
import 'package:shift_handover_challenge/src/domain/model/model.dart';
import 'package:shift_handover_challenge/src/domain/repository/src/shift_report_repository.dart';

final class ShiftReportRepositoryImpl implements ShiftReportRepository {
  @override
  Future<ShiftReport> getShiftReport(String caregiverId) async {
    await Future.delayed(const Duration(seconds: 1));
    return ShiftReport(
      id: 'shift-123',
      caregiverId: caregiverId,
      startTime: DateTime.now().subtract(const Duration(hours: 8)),
      notes: List.generate(5, (index) {
        final type = NoteType.values[Random().nextInt(NoteType.values.length)];
        return HandoverNote(
          id: 'note-$index',
          text: 'This is a sample note of type ${type.name}.',
          type: type,
          timestamp: DateTime.now().subtract(Duration(hours: index)),
          authorId: 'caregiver-A',
        );
      }),
    );
  }

  @override
  Future<bool> submitShiftReport(ShiftReport report) async {
    await Future.delayed(const Duration(seconds: 2));

    if (Random().nextBool()) {
      debugPrint(
          'Report submitted successfully for caregiver ${report.caregiverId}');
      return true;
    } else {
      debugPrint('Failed to submit report for caregiver ${report.caregiverId}');
      throw Exception('Network error: Failed to submit report.');
    }
  }
}
