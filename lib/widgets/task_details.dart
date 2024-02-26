import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_3/providers/providers.dart';
import 'package:todo_app_3/utils/utils.dart';
import 'package:todo_app_3/widgets/widgets.dart';

import '../data/data.dart';

class TaskDetails extends ConsumerWidget {
  const TaskDetails({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(timeProvider);
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          CircleConatiner(
            color: task.category.color.withOpacity(.3),
            child: Icon(
              task.category.icon,
              color: task.category.color,
            ),
          ),
          const Gap(16),
          Text(
            task.title,
            style: style.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(time.format(context), style: style.titleMedium),
          const Gap(16),
          Visibility(
            visible: !task.isCompleted,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('task to be complete on ${task.date}'),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                ),
              ],
            ),
          ),
          Visibility(
            visible: task.isCompleted,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('task completed'),
                Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const Gap(16),
          Divider(
            thickness: 1.5,
            color: task.category.color,
          ),
          const Gap(16),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                task.note.isEmpty
                    ? 'There is no additional note for this task'
                    : task.note,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
