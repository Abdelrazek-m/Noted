import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_3/data/data.dart';
import 'package:todo_app_3/providers/providers.dart';
import 'package:todo_app_3/utils/utils.dart';

class AppAlerts {
  AppAlerts._();

  static dusplaySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyLarge
              ?.copyWith(color: context.colorScheme.surface),
        ),
        duration: const Duration(milliseconds: 600),
        backgroundColor: context.colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top:Radius.circular(16))),
        // margin: EdgeInsets.symmetric( horizontal: 10),
      ),
    );
  }

  static Future<void> showDeleteAlertDialog(
      BuildContext context, WidgetRef ref, Task task) async {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text(
        'NO',
      ),
    );
    Widget deleteButton = TextButton(
      onPressed: () {
        ref.read(taskProvider.notifier).deleteTask(task).then((value) {
          AppAlerts.dusplaySnackBar(context, 'Task delete successfully',);
        });
        Navigator.of(context).pop();
      },
      child: const Text(
        'YES',
      ),
    );

    AlertDialog deleteAlertDialog = AlertDialog(
      title: const Text('Are you sure you want to delete this task?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    showDialog(
      context: context,
      builder: (ctx) => deleteAlertDialog,
    );
  }
}
