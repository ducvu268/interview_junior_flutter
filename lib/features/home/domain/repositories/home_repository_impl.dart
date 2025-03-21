import 'package:injectable/injectable.dart';
import 'package:interview_junior_flutter/core/services/database_service.dart';
import 'package:interview_junior_flutter/features/home/domain/models/task_model.dart';
import 'package:interview_junior_flutter/features/home/domain/repositories/home_repository.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  final _dbService = DatabaseService.instance;

  @override
  Future<bool> addTask(TaskModel task) async {
    final db = await _dbService.database;
    try {
      int insertId = await db.insert('tasks', task.toJson());
      if (insertId > 0) {
        task = task.copyWith(id: insertId);
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getTasks({bool onlyTaskInProgress = false}) async {
    final db = await _dbService.database;
    String whereClause = onlyTaskInProgress ? "WHERE status = 0" : "";
    try {
      final result = await db.rawQuery("SELECT * FROM tasks $whereClause");
      return result
          .map((json) => TaskModel.fromJson(json))
          .toList()
          .reversed
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateTask(TaskModel task) async {
    final db = await _dbService.database;
    final updatedTask = task.copyWith(
      updated_at: DateTime.now().toIso8601String(),
    );
    try {
      int updatedRows = await db.update(
        'tasks',
        updatedTask.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
      return updatedRows > 0;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTask(int id) async {
    final db = await _dbService.database;
    try {
      int deletedRows = await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
      return deletedRows > 0;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateTaskStatus(int taskId, int newStatus) async {
    try {
      final db = await _dbService.database;
      int count = await db.update(
        'tasks',
        {'status': newStatus, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ?',
        whereArgs: [taskId],
      );
      return count > 0;
    } catch (e) {
      rethrow;
    }
  }
}
