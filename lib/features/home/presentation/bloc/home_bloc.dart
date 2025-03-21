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
    on<TaskDetailInitialEvent>(onTaskDetailInitial);
    on<CreateTaskEvent>(onCreateTask);
    on<DeleteTaskEvent>(onDeleteTask);
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
      emit(currentState.copyWith(tabSelect: event.tab));
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

  void onChangedInputReceiver(
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
        var request = currentState.dataRequest.copyWith(
          due_date: TaskModel.convertToDBFormat(currentDueDate),
        );
        var result = await homeRepository.addTask(request);
        emit(currentState.copyWith(isLoading: false, isHandleSuccess: result));
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
        var result = await homeRepository.deleteTask(event.id);
        emit(currentState.copyWith(isLoading: false, isHandleSuccess: result));
      } catch (e) {
        emit(currentState.copyWith(isLoading: false));
        debugPrint(e.toString());
      }
    }
  }
}
