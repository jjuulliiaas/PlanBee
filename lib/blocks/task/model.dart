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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category_id': category?.id,
      'created_at': createdAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'is_high_priority': isHighPriority ? 1 : 0,
      'time_spent_ms': timeSpent?.inMilliseconds,
      'status': status.name
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, {CategoryModel? category}) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: category,
      createdAt: DateTime.parse(map['created_at']),
      deadline: DateTime.parse(map['deadline']),
      isHighPriority: map['is_high_priority'] == 1,
      timeSpent: map['time_spent_ms'] != null ? Duration(milliseconds: map['time_spent_ms']) : null,
      status: TaskStatus.values.byName(map['status']),
    );
  }

  TaskModel copyWith({
    TaskStatus? status,
  }) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      category: category,
      createdAt: createdAt,
      deadline: deadline,
      isHighPriority: isHighPriority,
      timeSpent: timeSpent,
      status: status ?? this.status,
    );
  }

  TaskStatus get effectiveStatus {
    if (status == TaskStatus.completed) return TaskStatus.completed;

    if (status == TaskStatus.inProgress) return TaskStatus.inProgress;

    if (deadline.isBefore(DateTime.now())) {
      return TaskStatus.missed;
    }

    return status;
  }

  bool get isCompleted => status == TaskStatus.completed;

}