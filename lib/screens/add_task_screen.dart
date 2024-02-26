import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_3/data/data.dart';
import 'package:todo_app_3/providers/providers.dart';
import 'package:todo_app_3/utils/utils.dart';
import '../widgets/widgets.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(10),
              const SelectCategory(),
              const Gap(10),
              const CommonSelectDateTime(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Task note',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(60),
              ElevatedButton(
                onPressed: _createTask,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: DisplayWhiteText(
                    text: 'Save',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        note: note,
        time: time.toString(),
        date: DateFormat.yMMMd().format(date),
        isCompleted: false,
        category: category,
      );
      await ref.read(taskProvider.notifier).createTask(task).then(
        (value) {
          AppAlerts.dusplaySnackBar(context, 'task created successfully');
          Navigator.pop(context);
        },
      );
    } else {
      AppAlerts.dusplaySnackBar(context, 'task Title cannot be empty');
    }
  }
}
