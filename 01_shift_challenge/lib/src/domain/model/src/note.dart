import 'package:flutter/foundation.dart' show immutable;
import 'package:shift_handover_challenge/src/domain/model/src/report.dart';

@immutable
class HandoverNote {
  final String id;
  final String text;
  final NoteType type;
  final String authorId;
  final DateTime timestamp;
  final bool isAcknowledged;
  final List<String> taggedResidentIds;

  const HandoverNote({
    required this.id,
    required this.text,
    required this.type,
    required this.authorId,
    required this.timestamp,
    this.isAcknowledged = false,
    this.taggedResidentIds = const [],
  });

  HandoverNote copyWith({
    String? id,
    String? text,
    NoteType? type,
    String? authorId,
    DateTime? timestamp,
    bool? isAcknowledged,
    List<String>? taggedResidentIds,
  }) {
    return HandoverNote(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      authorId: authorId ?? this.authorId,
      taggedResidentIds: taggedResidentIds ?? this.taggedResidentIds,
      isAcknowledged: isAcknowledged ?? this.isAcknowledged,
    );
  }

// Color getColor() {
//   switch (type) {
//     case NoteType.incident:
//       return Colors.red.shade100;
//     case NoteType.supplyRequest:
//       return Colors.yellow.shade100;
//     case NoteType.observation:
//     default:
//       return Colors.blue.shade100;
//   }
// }
}
