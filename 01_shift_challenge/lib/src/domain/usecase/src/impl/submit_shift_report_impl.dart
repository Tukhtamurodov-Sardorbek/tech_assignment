import 'package:shift_handover_challenge/src/domain/model/src/report.dart';
import 'package:shift_handover_challenge/src/domain/repository/repository.dart';
import 'package:shift_handover_challenge/src/domain/usecase/src/shift_handover_usecases.dart';

final class SubmitShiftReportImpl implements SubmitShiftReport {
  final ShiftReportRepository _repository;

  const SubmitShiftReportImpl(this._repository);

  @override
  Future<ShiftReport?> submit(ShiftReport report, String summary) async {
    final updatedReport = report.copyWith(
      summary: summary,
      isSubmitted: true,
      endTime: DateTime.now(),
    );
    final result = await _repository.submitShiftReport(updatedReport);
    if (result) {
      return updatedReport;
    }
    return null;
  }
}
