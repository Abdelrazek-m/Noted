import 'package:todo_app_3/data/data.dart';

abstract class TaskRepository{
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Future<List<Task>> getAllTasks();
}