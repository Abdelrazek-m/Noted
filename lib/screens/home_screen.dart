import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_3/data/data.dart';
import 'package:todo_app_3/screens/add_task_screen.dart';
import 'package:todo_app_3/utils/utils.dart';
import 'package:todo_app_3/widgets/widgets.dart';
import '../providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskProvider);
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final List<Task> notCompletedTasks = _incompletedTasks(taskState.tasks);
    final List<Task> completedTasks = _completedTasks(taskState.tasks);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * .3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: DateFormat.yMMMd().format(DateTime.now()),
                    ),
                    const Gap(10),
                    const DisplayWhiteText(
                      text: 'My Todo List',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: deviceSize.height * .15,
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DisplayListOfTasks(
                      tasks: notCompletedTasks,
                    ),
                    const Gap(20),
                    Text(
                      'Completed',
                      style: context.textTheme.headlineMedium,
                    ),
                    const Gap(20),
                    DisplayListOfTasks(
                      tasks: completedTasks,
                      isCompletedTasks: true,
                    ),
                    const Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTaskScreen(),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: DisplayWhiteText(
                          text: 'Add New Task',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _completedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }

  List<Task> _incompletedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        filteredTasks.add(task);
      }
    }
    return filteredTasks;
  }
}
