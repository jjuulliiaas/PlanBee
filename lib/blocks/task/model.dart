enum TaskStatus {planned, inProgress, completed, missed}

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final DateTime createdAt;
  final DateTime deadline;
  final bool isHighPriority;
  final Duration? timeSpent;
  final TaskStatus status;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    required this.createdAt,
    required this.deadline,
    this.isHighPriority = false,
    this.timeSpent,
    this.status = TaskStatus.planned
});

}