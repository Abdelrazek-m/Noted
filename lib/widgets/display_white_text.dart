import 'package:flutter/material.dart';
import 'package:todo_app_3/utils/utils.dart';

class DisplayWhiteText extends StatelessWidget {
  const DisplayWhiteText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
          color: context.colorScheme.surface,
          fontSize: fontSize ?? 20,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
