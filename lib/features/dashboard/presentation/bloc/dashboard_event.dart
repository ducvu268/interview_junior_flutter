part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class InitialDataEvent extends DashboardEvent {
  const InitialDataEvent();

  @override
  List<Object?> get props => [...super.props];
}

class EventChangeScreen extends DashboardEvent {
  final int currentPageIndex;

  const EventChangeScreen(this.currentPageIndex);

  @override
  List<Object?> get props => [...super.props, currentPageIndex];
}
