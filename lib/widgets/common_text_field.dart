import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_3/utils/extensions.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.title,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.suffixIcon,  this.readOnly=false,
  });

  final String title, hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final int maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),
        TextField(
          readOnly: readOnly,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
          onChanged: onChanged,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        )
      ],
    );
  }
}
