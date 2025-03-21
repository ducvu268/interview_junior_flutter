import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/configs/app_router.dart';
import 'package:interview_junior_flutter/core/di/injector.dart';
import 'package:interview_junior_flutter/core/localization/app_localizations.dart';
import 'package:interview_junior_flutter/core/themes/bloc/theme_bloc.dart';
import 'package:interview_junior_flutter/core/themes/theme_global.dart';

class TestFlutterInterviewApp extends StatelessWidget {
  const TestFlutterInterviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (__) => getIt<ThemeBloc>()..add(InitialThemeEvent()),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (__, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test Flutter Junior',
            themeMode: ThemeMode.system,
            theme: (state.isDarkMode)
                ? ThemeGlobal.darkTheme
                : ThemeGlobal.lightTheme,
            locale: Locale('en'),
            supportedLocales: const [
              Locale('en'), // English
              Locale('vi'), // Vietnam
            ],
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: AppRoutes.initialRoute,
          );
        },
      ),
    );
  }
}
