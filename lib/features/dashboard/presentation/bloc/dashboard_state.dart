part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboardLoadSuccess extends DashboardState {
  final bool isLoading;
  final int pageIndex;
  final UserInfoModel userInfoModel;

  DashboardLoadSuccess(this.isLoading, this.pageIndex, this.userInfoModel);

  DashboardLoadSuccess copyWith({
    bool? isLoading,
    int? pageIndex,
    UserInfoModel? userInfoModel,
  }) {
    return DashboardLoadSuccess(
      isLoading ?? this.isLoading,
      pageIndex ?? this.pageIndex,
      userInfoModel ?? this.userInfoModel,
    );
  }

  @override
  List<Object> get props => [isLoading, pageIndex, userInfoModel];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
