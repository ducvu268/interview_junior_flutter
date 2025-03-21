part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadSuccess extends HomeState {
  final bool isLoading;
  final String tabSelect;
  final List<TaskModel> tasks;
  final List<TaskModel> tasksByFilter;
  final bool isHandleSuccess;

  HomeLoadSuccess(
    this.isLoading,
    this.tabSelect,
    this.tasks,
    this.tasksByFilter,
    this.isHandleSuccess,
  );

  HomeLoadSuccess copyWith({
    bool? isLoading,
    String? tabSelect,
    List<TaskModel>? tasks,
    List<TaskModel>? tasksByFilter,
    bool? isHandleSuccess,
  }) {
    return HomeLoadSuccess(
      isLoading ?? this.isLoading,
      tabSelect ?? this.tabSelect,
      tasks ?? this.tasks,
      tasksByFilter ?? this.tasksByFilter,
      isHandleSuccess ?? this.isHandleSuccess,
    );
  }

  @override
  List<Object> get props => [isLoading, tabSelect, tasks, tasksByFilter, isHandleSuccess];
}

class TaskDetailLoadSuccess extends HomeState {
  final bool isLoading;
  final TaskModel dataRequest;
  final bool isHandleSuccess;

  TaskDetailLoadSuccess(this.isLoading, this.dataRequest, this.isHandleSuccess);

  TaskDetailLoadSuccess copyWith({
    bool? isLoading,
    TaskModel? dataRequest,
    bool? isHandleSuccess,
  }) {
    return TaskDetailLoadSuccess(
      isLoading ?? this.isLoading,
      dataRequest ?? this.dataRequest,
      isHandleSuccess ?? this.isHandleSuccess,
    );
  }

  @override
  List<Object> get props => [isLoading, dataRequest, isHandleSuccess];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
