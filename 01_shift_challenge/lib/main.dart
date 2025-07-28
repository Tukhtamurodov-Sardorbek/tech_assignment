import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shift_handover_challenge/app.dart';
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      configureDependencies();

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        ),
      );

      await Future.wait<dynamic>([
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      ]);

      if (kDebugMode) {
        Bloc.observer = AppBlocObserver();
      }

      runApp(ShiftHandoverChallengeApp());
    },
    (error, stack) {
      debugPrintStack(stackTrace: stack, label: error.toString());
    },
  );
}