part of 'shift_handover_bloc.dart';

sealed class ShiftHandoverEvent extends Equatable {
  const ShiftHandoverEvent._();

  const factory ShiftHandoverEvent.load(String caregiverId) = _Load;

  const factory ShiftHandoverEvent.submit(String summary) = _Submit;

  const factory ShiftHandoverEvent.addNote({
    required String text,
    required NoteType type,
  }) = _AddNote;

  T when<T>({
    required T Function(String) load,
    required T Function(String) submit,
    required T Function(String, NoteType) addNote,
  }) {
    return switch (this) {
      _Submit(:final summary) => submit(summary),
      _Load(:final caregiverId) => load(caregiverId),
      _AddNote(:final text, :final type) => addNote(text, type),
    };
  }

  T? whenOrNull<T>({
    T Function(String)? load,
    T Function(String)? submit,
    T Function(String, NoteType)? addNote,
  }) {
    return switch (this) {
      _Submit(:final summary) => submit?.call(summary),
      _Load(:final caregiverId) => load?.call(caregiverId),
      _AddNote(:final text, :final type) => addNote?.call(text, type),
    };
  }

  T maybeWhen<T>({
    T Function(String)? load,
    T Function(String)? submit,
    T Function(String, NoteType)? addNote,
    required T Function() orElse,
  }) {
    return whenOrNull(load: load, submit: submit, addNote: addNote) ?? orElse();
  }
}

final class _Load extends ShiftHandoverEvent {
  final String caregiverId;

  const _Load(this.caregiverId) : super._();

  @override
  List<Object?> get props => [caregiverId];
}

final class _AddNote extends ShiftHandoverEvent {
  final String text;
  final NoteType type;

  const _AddNote({required this.text, required this.type}) : super._();

  @override
  List<Object?> get props => [text, type];
}

final class _Submit extends ShiftHandoverEvent {
  final String summary;

  const _Submit(this.summary) : super._();

  @override
  List<Object?> get props => [summary];
}
