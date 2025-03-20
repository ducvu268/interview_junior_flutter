import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_junior_flutter/core/di/injector.dart';
import 'package:interview_junior_flutter/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:interview_junior_flutter/features/dashboard/presentation/page/dashboard_screen.dart';
import 'package:interview_junior_flutter/features/splash/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = '/splash';
  static const String dashboard = '/dashboard';
  static const String taskDetail = '/task_detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case dashboard:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<DashboardBloc>(
                    create: (_) => getIt<DashboardBloc>(),
                  ),
                ],
                child: DashboardScreen(),
              ),
        );
      case taskDetail:
        // final args = settings.arguments as dynamic;
        // if (args == null) {
        //   return MaterialPageRoute(builder: (_) => const SizedBox.shrink());
        // }
        // return MaterialPageRoute(
        //   builder:
        //       (_) => BlocProvider(
        //         create: (_) => getIt<TaskDetailBloc>(),
        //         child: TaskDetailScreen(arguments: args),
        //       ),
        // );

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page Not Found')),
              ),
        );
    }
  }
}
