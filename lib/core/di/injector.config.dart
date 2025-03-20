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

import '../../features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i665;
import '../../features/dashboard/domain/repositories/dashboard_repository_impl.dart'
    as _i714;
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart'
    as _i652;
import '../services/local_storage_service.dart' as _i527;
import '../themes/bloc/theme_bloc.dart' as _i339;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i339.ThemeBloc>(() => _i339.ThemeBloc());
    gh.lazySingleton<_i527.LocalStorageService>(
      () => _i527.LocalStorageService(),
    );
    gh.factory<_i665.DashboardRepository>(
      () => _i714.DashboardRepositoryImpl(),
    );
    gh.factory<_i652.DashboardBloc>(
      () => _i652.DashboardBloc(
        dashboardRepository: gh<_i665.DashboardRepository>(),
      ),
    );
    return this;
  }
}
