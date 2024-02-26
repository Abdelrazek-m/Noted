import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data.dart';
import '/providers/providers.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  final TaskRepository _repository;
  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getAllTasks();
  }

  Future<void> createTask(Task task) async {
    try {
      await _repository.createTask(task);
      getAllTasks();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatesTask = task.copyWith(isCompleted: isCompleted);

      await _repository.updateTask(updatesTask);
      getAllTasks();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getAllTasks();
    } catch (e) {
      log(e.toString());
    }
  }

  void getAllTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      log(e.toString());
    }
  }
}
