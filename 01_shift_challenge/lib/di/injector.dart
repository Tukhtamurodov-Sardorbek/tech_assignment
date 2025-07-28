import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shift_handover_challenge/di/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
GetIt configureDependencies() => getIt.init();
