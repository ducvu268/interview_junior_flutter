import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';
import 'package:interview_junior_flutter/features/home/domain/repositories/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<HomeInitialEvent>(onHomeInitial);
    on<TabChangeEvent>(onTabChange);
    on<SearchTaskEvent>(onSearchTask);
    on<ToggleStatusEvent>(onToggleStatus);
    on<TaskDetailInitialEvent>(onTaskDetailInitial);
    on<ChangedInputTaskEvent>(onChangedInputTask);
    on<CreateTaskEvent>(onCreateTask);
    on<DeleteTaskEvent>(onDeleteTask);
    on<UpdateTaskEvent>(onUpdateTask);
  }

  Future<void> onHomeInitial(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final tasks = await homeRepository.getTasks();
      emit(HomeLoadSuccess(false, 'All', tasks, tasks, false));
    } catch (e) {
      debugPrint('Error initial home screen data: $e');
      emit(HomeError(e.toString()));
    }
  }

  void onTabChange(TabChangeEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadSuccess) {
      final currentState = state as HomeLoadSuccess;
      List<TaskModel> tasks = currentState.tasks;
      if (event.tab == 'All') {
        tasks = currentState.tasks;
      } else if (event.tab == 'To do') {
        tasks = currentState.tasks.where((t) => t.status == 0).toList();
      } else if (event.tab == 'Done') {
        tasks = currentState.tasks.where((t) => t.status == 1).toList();
      }
      emit(currentState.copyWith(tabSelect: event.tab, tasksByFilter: tasks));
    }
  }

  void onSearchTask(SearchTaskEvent event, Emitter<HomeState> emit) {
    if (state is HomeLoadSuccess) {
      final currentState = state as HomeLoadSuccess;
      List<TaskModel> tasks = currentState.tasks;
      if (currentState.tabSelect == 'All') {
        tasks = currentState.tasks;
      } else if (currentState.tabSelect == 'To do') {
        tasks = currentState.tasks.where((t) => t.status == 0).toList();
      } else if (currentState.tabSelect == 'Done') {
        tasks = currentState.tasks.where((t) => t.status == 1).toList();
      }
      var result =
          tasks
              .where(
                (task) => task.title.toLowerCase().contains(
                  event.query.toLowerCase(),
                ),
              )
              .toList();
      emit(currentState.copyWith(tasksByFilter: result));
    }
  }

  Future<void> onToggleStatus(
    ToggleStatusEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! HomeLoadSuccess) return;

    final currentState = state as HomeLoadSuccess;
    emit(currentState.copyWith(isLoading: true, isHandleSuccess: false));

    try {
      var currentStatus = event.taskModel.status;
      bool isUpdated = await homeRepository.updateTaskStatus(
        event.taskModel.id ?? -1,
        (currentStatus == 1) ? 0 : 1,
      );

      if (isUpdated) {
        var updatedTasks = await homeRepository.getTasks();
        emit(
          currentState.copyWith(
            isLoading: false,
            tasks: updatedTasks,
            tasksByFilter: updatedTasks,
            isHandleSuccess: true,
          ),
        );
      } else {
        throw Exception("Update status tasks failed.");
      }
    } catch (e) {
      emit(currentState.copyWith(isLoading: false, isHandleSuccess: false));
      debugPrint("Error form update status task: $e");
    }
  }

  Future<void> onTaskDetailInitial(
    TaskDetailInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      dynamic data = event.data;
      emit(
        TaskDetailLoadSuccess(
          false,
          data is TaskModel ? data : TaskModel.empty(),
          false,
        ),
      );
    } catch (e) {
      debugPrint('Error initial home screen data: $e');
      emit(HomeError(e.toString()));
    }
  }

  void onChangedInputTask(
    ChangedInputTaskEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state is TaskDetailLoadSuccess) {
      final currentState = state as TaskDetailLoadSuccess;
      final currentModel = currentState.dataRequest;
      if (event.field == 'title') {
        emit(
          currentState.copyWith(
            dataRequest: currentModel.copyWith(title: event.value),
          ),
        );
      } else if (event.field == 'description') {
        emit(
          currentState.copyWith(
            dataRequest: currentModel.copyWith(description: event.value),
          ),
        );
      } else if (event.field == 'due_date') {
        emit(
          currentState.copyWith(
            dataRequest: currentModel.copyWith(due_date: event.value),
          ),
        );
      }
    }
  }

  Future<void> onCreateTask(
    CreateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is TaskDetailLoadSuccess) {
      final currentState = state as TaskDetailLoadSuccess;
      emit(currentState.copyWith(isLoading: true));
      try {
        var currentDueDate = currentState.dataRequest.due_date;
        var currentTask = currentState.dataRequest;
        var request = currentTask.copyWith(
          due_date: TaskModel.convertToDBFormat(currentDueDate),
        );
        var isCreated = await homeRepository.addTask(request);
        emit(
          currentState.copyWith(isLoading: false, isHandleSuccess: isCreated),
        );
      } catch (e) {
        emit(currentState.copyWith(isLoading: false));
        debugPrint(e.toString());
      }
    }
  }

  Future<void> onDeleteTask(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoadSuccess) {
      final currentState = state as HomeLoadSuccess;
      emit(currentState.copyWith(isLoading: true));
      try {
        var isDeleted = await homeRepository.deleteTask(event.id);
        if (isDeleted) {
          final newTasks = List<TaskModel>.from(currentState.tasks)
            ..removeWhere((task) => task.id == event.id);
          emit(
            currentState.copyWith(
              isLoading: false,
              tasks: newTasks,
              tasksByFilter: newTasks,
              isHandleSuccess: isDeleted,
            ),
          );
        } else {
          throw Exception("Delete task failed.");
        }
      } catch (e) {
        emit(currentState.copyWith(isLoading: false));
        debugPrint(e.toString());
      }
    }
  }

  Future<void> onUpdateTask(
    UpdateTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! TaskDetailLoadSuccess) return;

    final currentState = state as TaskDetailLoadSuccess;
    emit(currentState.copyWith(isLoading: true, isHandleSuccess: false));

    try {
      final currentTask = currentState.dataRequest;
      final updatedTask = currentTask.copyWith(
        updated_at: DateTime.now().toIso8601String(),
      );

      bool isUpdated = await homeRepository.updateTask(updatedTask);

      if (isUpdated) {
        emit(
          currentState.copyWith(
            isLoading: false,
            dataRequest: updatedTask,
            isHandleSuccess: isUpdated,
          ),
        );
      } else {
        throw Exception("Update tasks failed.");
      }
    } catch (e) {
      emit(currentState.copyWith(isLoading: false, isHandleSuccess: false));
      debugPrint("Error form update task: $e");
    }
  }
}
