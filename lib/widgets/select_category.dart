import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app_3/data/data.dart';
import 'package:todo_app_3/providers/providers.dart';
import 'package:todo_app_3/utils/extensions.dart';
import '../widgets/widgets.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategory.values.toList();
    const double iconOpacity = 0.4, backgroundOpacity = 0.3;
    // final double iconOpacity = task.isCompleted ? 0.3 : 0.5;
    // final double backgroundOpacity = task.isCompleted ? 0.1 : 0.3;
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Category',
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    ref.read(categoryProvider.notifier).state = category;
                  },
                  child: CircleConatiner(
                    color: category.color.withOpacity(backgroundOpacity),
                    child: Icon(
                      category.icon,
                      color: category == selectedCategory
                          ? category.color
                          : category.color.withOpacity(iconOpacity),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Gap(8),
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }
}
