import 'package:injectable/injectable.dart';
import 'package:shift_handover_challenge/src/domain/repository/repository.dart';
import 'package:shift_handover_challenge/src/domain/usecase/usecase.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/impl/update_report_impl.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/impl/get_shift_report_impl.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/impl/submit_shift_report_impl.dart';

@module
abstract class UsecaseModule {
  GetShiftReport injectGetShiftReport(ShiftReportRepository repository) {
    return GetShiftReportImpl(repository);
  }

  SubmitShiftReport injectSubmitShiftReport(ShiftReportRepository repository) {
    return SubmitShiftReportImpl(repository);
  }

  UpdateReport injectUpdateReport() => UpdateReportImpl();
}
