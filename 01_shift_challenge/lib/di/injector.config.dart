// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart'
    as _i746;
import 'package:shift_handover_challenge/src/app/app_bloc/di/module.dart'
    as _i963;
import 'package:shift_handover_challenge/src/domain/repository/di/module.dart'
    as _i452;
import 'package:shift_handover_challenge/src/domain/repository/repository.dart'
    as _i915;
import 'package:shift_handover_challenge/src/domain/usecase/di/module.dart'
    as _i533;
import 'package:shift_handover_challenge/src/domain/usecase/usecase.dart'
    as _i602;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final repositoryModule = _$RepositoryModule();
    final usecaseModule = _$UsecaseModule();
    final appBlocModule = _$AppBlocModule();
    gh.factory<_i915.ShiftReportRepository>(
        () => repositoryModule.injectShiftReportRepository());
    gh.factory<_i602.UpdateReport>(() => usecaseModule.injectUpdateReport());
    gh.factory<_i602.GetShiftReport>(() =>
        usecaseModule.injectGetShiftReport(gh<_i915.ShiftReportRepository>()));
    gh.factory<_i602.SubmitShiftReport>(() => usecaseModule
        .injectSubmitShiftReport(gh<_i915.ShiftReportRepository>()));
    gh.factory<_i746.ShiftHandoverBloc>(
        () => appBlocModule.injectShiftHandoverBloc(
              gh<_i602.UpdateReport>(),
              gh<_i602.GetShiftReport>(),
              gh<_i602.SubmitShiftReport>(),
            ));
    return this;
  }
}

class _$RepositoryModule extends _i452.RepositoryModule {}

class _$UsecaseModule extends _i533.UsecaseModule {}

class _$AppBlocModule extends _i963.AppBlocModule {}
