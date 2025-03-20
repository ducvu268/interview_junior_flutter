import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:interview_junior_flutter/app.dart';
import 'package:interview_junior_flutter/core/di/injector.dart';
import 'package:interview_junior_flutter/core/services/local_storage_service.dart';
import 'package:interview_junior_flutter/simple_bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    await LocalStorageService.init();
    await _hideSystemUI();
    Bloc.observer = SimpleBlocObserver();

    runApp(TestFlutterInterviewApp());
  }, (error, stack) {
    debugPrint('error in main = $error');
  });
}

Future<void> _hideSystemUI() async {
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );
  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
    if (systemOverlaysAreVisible) {
      await Future.delayed(const Duration(seconds: 3));
      SystemChrome.restoreSystemUIOverlays();
    }
  });
}
