import 'package:get_it/get_it.dart';
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart';

final class GetAppBloc {
  const GetAppBloc._();

  static ShiftHandoverBloc get shiftHandover =>
      GetIt.I.get<ShiftHandoverBloc>();
}
