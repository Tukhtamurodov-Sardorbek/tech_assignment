import 'package:injectable/injectable.dart';
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart';
import 'package:shift_handover_challenge/src/domain/usecase/usecase.dart';

@module
abstract class AppBlocModule {
  ShiftHandoverBloc injectShiftHandoverBloc(
    UpdateReport updater,
    GetShiftReport getter,
    SubmitShiftReport submitter,
  ) =>
      ShiftHandoverBloc(updater, getter, submitter);
}
