import 'package:flutter/material.dart';
import 'package:planbee/core/utils/app_padding.dart';
import 'package:provider/provider.dart';

import '../../blocks/task/model.dart';
import '../../blocks/task/provider.dart';
import 'components/details_card.dart';
import 'components/input_card.dart';

class CreateEditBody extends StatefulWidget {
  const CreateEditBody({super.key, this.taskToEdit});

  final TaskModel? taskToEdit;

  @override
  State<CreateEditBody> createState() => _CreateEditBodyState();
}

class _CreateEditBodyState extends State<CreateEditBody> {
  final _key = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final task = widget.taskToEdit;

    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');

    Future.microtask(() {
      if (!mounted) return;
      final provider = context.read<TaskProvider>();
      if (task != null) {
        provider.loadTaskData(task);
      } else {
        provider.reset();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TaskProvider>();
      if (task != null) {
        provider.title = task.title;
        provider.description = task.description ?? '';
        provider.selectedDate = task.deadline;
        provider.selectedTime = TimeOfDay.fromDateTime(task.deadline);
        provider.selectedCategory = task.category;
        provider.isHighPriority = task.isHighPriority;
      } else {
        provider.reset();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputCard(
                titleController: _titleController,
                descriptionController: _descriptionController,
              ),
              SizedBox(height: AppPadding.vertical(context),),
              DetailsCard(),
              
            ],
          )
      ),
    );
  }
}
