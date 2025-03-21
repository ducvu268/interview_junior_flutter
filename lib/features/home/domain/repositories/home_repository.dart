import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';

abstract class HomeRepository {
  Future<bool> addTask(TaskModel task);

  Future<List<TaskModel>> getTasks({bool onlyTaskInProgress = false});

  Future<bool> updateTask(TaskModel task);

  Future<bool> deleteTask(int id);
}
