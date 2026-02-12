import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/core/utils/app_padding.dart';

import '../../blocks/task/model.dart';
import 'components/task_card/task_card.dart';

class HomeBody extends StatelessWidget {
   HomeBody({super.key});

  final List<TaskModel> mockTasks = [
    TaskModel(
      id: '1',
      title: 'Захист курсової роботи з дисципліни бла бла бла',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(hours: 2)),
      isHighPriority: true,
      status: TaskStatus.inProgress,
    ),
    TaskModel(
      id: '2',
      title: 'Купити продукти: макарони, помідори, огірок, мандарин',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.planned,
    ),
    TaskModel(
      id: '3',
      title: 'Захист курсової роботи',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(hours: 2)),
      isHighPriority: true,
      status: TaskStatus.completed,
    ),
    TaskModel(
      id: '4',
      title: 'Купити продукти',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.missed,
    ),
    TaskModel(
      id: '5',
      title: 'Захист курсової роботи',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(hours: 2)),
      isHighPriority: true,
      status: TaskStatus.inProgress,
    ),
    TaskModel(
      id: '6',
      title: 'Купити продукти',
      createdAt: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 1)),
      status: TaskStatus.planned,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
        padding: AppPadding.screen(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s plan',
                  style: textTheme.headlineMedium,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add, size: 20.r),
                  label: Text(
                    'Add',
                    style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 100.h),
                itemCount: mockTasks.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return TaskCard(task: mockTasks[index]);
                },
              ),
            ),
          ],
        )
    );
  }
}
