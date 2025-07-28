import 'dart:math' show Random;

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shift_handover_challenge/src/domain/usecase/usecase.dart';
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart';
import 'package:shift_handover_challenge/src/domain/model/model.dart';

part 'shift_handover_event.dart';

part 'shift_handover_state.dart';

class ShiftHandoverBloc extends Bloc<ShiftHandoverEvent, ShiftHandoverState> {
  final UpdateReport _updater;
  final GetShiftReport _getter;
  final SubmitShiftReport _submitter;

  ShiftHandoverBloc(this._updater, this._getter, this._submitter)
      : super(ShiftHandoverState.init()) {
    on<_AddNote>(_add);
    on<ShiftHandoverEvent>((event, emit) async {
      await event.whenOrNull(
        load: (id) => _load(id, emit),
        submit: (summary) => _submit(summary, emit),
      );
    });
  }

  Future<void> _load(String id, Emitter<ShiftHandoverState> emit) async {
    emit(ShiftHandoverState.loading(isSubmission: false));
    try {
      final report = await _getter.get(id);
      emit(ShiftHandoverState.loaded(report));
    } catch (e) {
      emit(ShiftHandoverState.error(e.toString()));
    }
  }

  Future<void> _submit(
    String summary,
    Emitter<ShiftHandoverState> emit,
  ) async {
    final report = state.whenOrNull(loaded: (report) => report);
    if (report == null) return;

    emit(ShiftHandoverState.loading(isSubmission: true));
    try {
      final result = await _submitter.submit(report, summary);

      if (result != null) {
        emit(ShiftHandoverState.loaded(result));
      } else {
        emit(ShiftHandoverState.error('Failed to submit report'));
      }
    } catch (e) {
      emit(ShiftHandoverState.error(e.toString()));
    }
  }

  void _add(_AddNote event, Emitter<ShiftHandoverState> emit) {
    final report = state.whenOrNull(loaded: (report) => report);
    if (report == null) return;
    final updatedReport = _updater.addNote(report, event.text, event.type);

    if (Random().nextDouble() > 0.2) {
      emit(ShiftHandoverState.loaded(updatedReport));
    } else {
      debugPrint("Note added but state not emitted.");
    }
  }
}
