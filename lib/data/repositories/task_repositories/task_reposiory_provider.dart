import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_3/data/datasource/datasource.dart';
import 'package:todo_app_3/data/repositories/repositories.dart';

final taskRepositoryProvider = Provider<TaskRepositoryImpl>((ref) {
  final datasource =ref.watch(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});