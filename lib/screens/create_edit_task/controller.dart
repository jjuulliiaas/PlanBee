import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planbee/blocks/task/provider.dart';
import 'package:planbee/screens/create_edit_task/components/pickers/date_picker.dart';
import 'package:planbee/widgets/base_picker_layout.dart';
import 'package:uuid/uuid.dart';

import '../../blocks/task/model.dart';
import 'components/pickers/time_picker.dart';

class CreateEditController {
  final TaskProvider provider;

  CreateEditController({required this.provider});

  Future<void> onSaveTask(BuildContext context) async {
    if(provider.title.isEmpty) return;

    provider.isLoading = true;

    try {
      final newTask = TaskModel(
        id: const Uuid().v4(),
        title: provider.title,
        description: provider.description,
        categoryId: provider.categoryId,
        createdAt: DateTime.now(),
        deadline: provider.fullDeadline,
        isHighPriority: provider.isHighPriority,
      );

      print('Task Saved: ${newTask.title} with deadline ${newTask.deadline}');

      Navigator.maybePop(context);
    } catch (e) {
      print('Error saving task: $e');
    } finally {
      provider.isLoading = false;
    }
  }

  Future<void> onSelectDate(BuildContext context) async {
    final DateTime? pickedDate = await BasePickerLayout.show<DateTime>(
        context: context,
        child: DatePicker(
          initialDate: provider.selectedDate,
        )
    );
    if(pickedDate != null) {
      provider.selectedDate = pickedDate;
    }
  }

  Future<void> onSelectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await BasePickerLayout.show<TimeOfDay>(
        context: context,
        child: TimePicker(
          initialTime: provider.selectedTime,
        )
    );
    if(pickedTime != null) {
      provider.selectedTime = pickedTime;
    }
  }

  void onTogglePriority(bool value) {
    provider.isHighPriority = value;
  }


}