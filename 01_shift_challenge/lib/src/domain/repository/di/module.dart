import 'package:injectable/injectable.dart';
import 'package:shift_handover_challenge/src/domain/repository/repository.dart';
import 'package:shift_handover_challenge/src/domain/repository/src/impl/shift_report_repository_impl.dart';

@module
abstract class RepositoryModule {
  ShiftReportRepository injectShiftReportRepository() {
    return ShiftReportRepositoryImpl();
  }
}
