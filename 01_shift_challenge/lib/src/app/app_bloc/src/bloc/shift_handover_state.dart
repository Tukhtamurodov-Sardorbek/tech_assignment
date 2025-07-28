part of 'shift_handover_bloc.dart';

sealed class ShiftHandoverState extends Equatable {
  const ShiftHandoverState._();

  const factory ShiftHandoverState.init() = _Initial;

  const factory ShiftHandoverState.loading({required bool isSubmission}) =
      _Loading;

  const factory ShiftHandoverState.loaded(ShiftReport report) = _Loaded;

  const factory ShiftHandoverState.error(String message) = _Error;

  T when<T>({
    required T Function() init,
    required T Function(bool) loading,
    required T Function(String) error,
    required T Function(ShiftReport) loaded,
  }) {
    return switch (this) {
      _Initial() => init(),
      _Loaded(:final data) => loaded(data),
      _Error(:final message) => error(message),
      _Loading(:final isSubmission) => loading(isSubmission),
    };
  }

  T? whenOrNull<T>({
    T Function()? init,
    T Function(bool)? loading,
    T Function(String)? error,
    T Function(ShiftReport)? loaded,
  }) {
    return switch (this) {
      _Initial() => init?.call(),
      _Loaded(:final data) => loaded?.call(data),
      _Error(:final message) => error?.call(message),
      _Loading(:final isSubmission) => loading?.call(isSubmission),
    };
  }

  T maybeWhen<T>({
    T Function()? init,
    T Function(bool)? loading,
    T Function(String)? error,
    T Function(ShiftReport)? loaded,
    required T Function() orElse,
  }) {
    return whenOrNull(
          init: init,
          error: error,
          loaded: loaded,
          loading: loading,
        ) ??
        orElse();
  }
}

final class _Initial extends ShiftHandoverState {
  const _Initial() : super._();

  @override
  List<Object> get props => [];
}

final class _Loading extends ShiftHandoverState {
  final bool isSubmission;

  const _Loading({required this.isSubmission}) : super._();

  @override
  List<Object> get props => [isSubmission];
}

final class _Loaded extends ShiftHandoverState {
  final ShiftReport data;

  const _Loaded(this.data) : super._();

  @override
  List<Object?> get props => [data];
}

final class _Error extends ShiftHandoverState {
  final String message;

  const _Error(this.message) : super._();

  @override
  List<Object> get props => [message];
}
