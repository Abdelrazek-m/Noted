import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_3/utils/utils.dart';
import '../data/data.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class DisplayListOfTasks extends ConsumerWidget {
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * .25 : deviceSize.height * .3;
    final emptyTasksMessage = isCompletedTasks
        ? 'There is no completed tasks yet'
        : 'There is no tasks todo';
    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTasksMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: tasks.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    AppAlerts.showDeleteAlertDialog(context, ref, task);
                  },
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return TaskDetails(
                          task: task,
                        );
                      },
                    );
                  },
                  child: TaskTile(
                    task: task,
                    onCompleted: (value) async {
                      await ref
                          .read(taskProvider.notifier)
                          .updateTask(task)
                          .then((value) {
                        AppAlerts.dusplaySnackBar(
                          context,
                          task.isCompleted
                              ? 'Task incompleted'
                              : 'Task completed',
                        );
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
