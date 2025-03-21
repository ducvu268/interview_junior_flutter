part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent();

  @override
  List<Object?> get props => [...super.props];
}

class TaskDetailInitialEvent extends HomeEvent {
  final dynamic data;

  const TaskDetailInitialEvent(this.data);

  @override
  List<Object?> get props => [...super.props, data];
}

class RefreshTasksEvent extends HomeEvent {
  const RefreshTasksEvent();

  @override
  List<Object?> get props => [...super.props];
}

class TabChangeEvent extends HomeEvent {
  final String tab;

  const TabChangeEvent(this.tab);

  @override
  List<Object?> get props => [...super.props, tab];
}

class SearchTaskEvent extends HomeEvent {
  final String query;

  const SearchTaskEvent(this.query);

  @override
  List<Object?> get props => [...super.props, query];
}

class ToggleStatusEvent extends HomeEvent {
  final bool status;

  const ToggleStatusEvent(this.status);

  @override
  List<Object?> get props => [...super.props, status];
}

class ChangedInputTaskEvent extends HomeEvent {
  final String value;
  final String field;

  const ChangedInputTaskEvent(this.value, this.field);

  @override
  List<Object?> get props => [...super.props, value, field];
}

class CreateTaskEvent extends HomeEvent {
  const CreateTaskEvent();

  @override
  List<Object?> get props => [...super.props];
}

class DeleteTaskEvent extends HomeEvent {
  final int id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [...super.props, id];
}
