import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../providers/providers.dart';
import 'widgets.dart';

class CommonSelectDateTime extends ConsumerWidget {
  const CommonSelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date=ref.watch(dateProvider);
    final time=ref.watch(timeProvider);
    
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: DateFormat.yMMMd().format(date),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectDate(context,ref),
              icon: const FaIcon(
                FontAwesomeIcons.calendar,
              ),
            ),
          ),
        ),
        const Gap(16),
        Expanded(
          child: CommonTextField(
            title: 'time',
            hintText: time.format(context),
            readOnly: true,
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context,ref),
              icon: const FaIcon(
                FontAwesomeIcons.clock,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    final initialTime=ref.read(timeProvider);
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null) {
      ref.read(timeProvider.notifier).state=pickedTime;
    }
  }

  void _selectDate(BuildContext context, WidgetRef ref) async {
    final initialDate=ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
        context: context,initialDate: initialDate, firstDate: DateTime.now(), lastDate: DateTime(2040));
    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state=pickedDate;
    }
  }
}
