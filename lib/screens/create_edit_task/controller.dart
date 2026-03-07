import 'package:flutter/material.dart';
import 'package:planbee/blocks/category/model.dart';
import 'package:planbee/blocks/category/provider.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/screens/create_edit_task/components/pickers/category_picker.dart';
import 'package:planbee/screens/create_edit_task/components/pickers/date_picker.dart';
import 'package:planbee/widgets/base_picker_layout.dart';
import 'package:uuid/uuid.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/repository.dart';
import 'components/pickers/create_new_category_picker.dart';
import 'components/pickers/time_picker.dart';

class CreateEditController {
  final TaskProvider taskProvider;
  final CategoryProvider categoryProvider;

  final TaskRepository _repository = TaskRepository();

  CreateEditController({
    required this.taskProvider,
    required this.categoryProvider
  });

  Future<void> onSaveTask(BuildContext context) async {
    if (taskProvider.title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    taskProvider.isLoading = true;

    final deadline = taskProvider.fullDeadline;
    if (deadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set both date and time')),
      );
      return;
    }

    try {
      final newTask = TaskModel(
        id: const Uuid().v4(),
        title: taskProvider.title,
        description: taskProvider.description,
        category: taskProvider.selectedCategory,
        createdAt: DateTime.now(),
        deadline: deadline,
        isHighPriority: taskProvider.isHighPriority,
        status: TaskStatus.planned
      );

      await _repository.saveTask(newTask);

      taskProvider.addTask(newTask);

      taskProvider.reset();
      if (context.mounted) Navigator.pop(context);

    } catch (e) {
      print('Error saving task: $e');
    } finally {
      taskProvider.isLoading = false;
    }
  }

  Future<void> onSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await BasePickerLayout.show<DateTime>(
        context: context,
        child: DatePicker(
          initialDate: taskProvider.selectedDate,
        )
    );
    if(pickedDate != null) {
      taskProvider.selectedDate = pickedDate;
    }
  }

  Future<void> onSelectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await BasePickerLayout.show<TimeOfDay>(
        context: context,
        child: TimePicker(
          initialTime: taskProvider.selectedTime,
        )
    );
    if(pickedTime != null) {
      taskProvider.selectedTime = pickedTime;
    }
  }

  Future<void> onSelectCategory(BuildContext context) async {
    taskProvider.tempSelectedCategory = taskProvider.selectedCategory;

    await BasePickerLayout.show<CategoryModel>(
        context: context,
        child: CategoryPicker(controller: this)
    );

    taskProvider.tempSelectedCategory = null;
  }

  void onTogglePriority(bool value) {
    taskProvider.isHighPriority = value;
  }

  void onTempSelectCategory(CategoryModel category) {
    taskProvider.tempSelectedCategory = category;
  }

  void onConfirmCategory(BuildContext context) {
    if (taskProvider.tempSelectedCategory != null) {
      taskProvider.selectedCategory = taskProvider.tempSelectedCategory;

      Navigator.pop(context);
    }
  }

  Future<void> onCreateNewCategory(BuildContext context) async {
    final newCat = await BasePickerLayout.show<CategoryModel>(
      context: context,
      child: const CreateNewCategoryPicker(),
    );

    if (newCat != null) {
      categoryProvider.addCategory(newCat);
      onTempSelectCategory(newCat);
    }
  }

  void onCancel(BuildContext context) {
    taskProvider.reset();
    Navigator.pop(context);
  }

}