import 'package:planbee/blocks/category/model.dart';

enum TaskStatus {planned, inProgress, completed, missed}

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final CategoryModel? category;
  final DateTime createdAt;
  final DateTime deadline;
  final bool isHighPriority;
  final Duration? timeSpent;
  final TaskStatus status;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.category,
    required this.createdAt,
    required this.deadline,
    this.isHighPriority = false,
    this.timeSpent,
    this.status = TaskStatus.planned
});

}