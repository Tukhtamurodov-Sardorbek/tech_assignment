import 'package:shift_handover_challenge/src/domain/model/src/report.dart';
import 'package:shift_handover_challenge/src/domain/repository/repository.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/shift_handover_usecases.dart';

final class GetShiftReportImpl implements GetShiftReport {
  final ShiftReportRepository _repository;

  const GetShiftReportImpl(this._repository);

  @override
  Future<ShiftReport> get(String id) => _repository.getShiftReport(id);
}
