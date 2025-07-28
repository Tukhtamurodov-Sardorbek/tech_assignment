import 'package:flutter/foundation.dart' show immutable;
import 'note.dart';

enum NoteType {
  observation,
  incident,
  medication,
  task,
  supplyRequest,
}

@immutable
class ShiftReport {
  final String id;
  final String caregiverId;
  final DateTime startTime;
  final DateTime? endTime;
  final List<HandoverNote> notes;
  final String summary;
  final bool isSubmitted;

  const ShiftReport({
    required this.id,
    required this.caregiverId,
    required this.startTime,
    this.endTime,
    this.summary = '',
    this.notes = const [],
    this.isSubmitted = false,
  });

  ShiftReport copyWith({
    String? id,
    String? caregiverId,
    DateTime? startTime,
    DateTime? endTime,
    List<HandoverNote>? notes,
    String? summary,
    bool? isSubmitted,
  }) {
    return ShiftReport(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      summary: summary ?? this.summary,
      endTime: endTime ?? this.endTime,
      startTime: startTime ?? this.startTime,
      caregiverId: caregiverId ?? this.caregiverId,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
