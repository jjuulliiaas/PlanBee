import 'package:flutter/material.dart';
import '../task/model.dart';
import '../task/provider.dart';

enum TaskSortOption { newest, oldest, priority, alphabet }

class AllTasksProvider extends ChangeNotifier {
  final TaskProvider taskProvider;

  TaskStatus? _filterStatus;
  DateTime _selectedDay = DateTime.now();
  bool _isDisposed = false;
  TaskSortOption _sortOption = TaskSortOption.newest;

  AllTasksProvider(this.taskProvider) {
    taskProvider.addListener(_onTaskProviderChanged);
  }

  void _onTaskProviderChanged() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    taskProvider.removeListener(_onTaskProviderChanged);
    super.dispose();
  }


  TaskStatus? get filterStatus => _filterStatus;
  DateTime get selectedDay => _selectedDay;
  TaskSortOption get sortOption => _sortOption;

  set filterStatus(TaskStatus? value) {
    if (_filterStatus == value) return;
    _filterStatus = value;
    notifyListeners();
  }

  set selectedDay(DateTime value) {
    if (DateUtils.isSameDay(_selectedDay, value)) return;
    _selectedDay = value;
    notifyListeners();
  }

  set sortOption(TaskSortOption value) {
    if (_sortOption == value) return;
    _sortOption = value;
    notifyListeners();
  }

  List<TaskModel> get filteredTasks {
    final allTasks = taskProvider.tasks;

    final List<TaskModel> filtered = _filterStatus == null
        ? List<TaskModel>.from(allTasks)
        : allTasks.where((t) => t.effectiveStatus == _filterStatus).toList();

    _applySorting(filtered);
    return filtered;
  }

  List<TaskModel> get tasksForSelectedDay {
    final tasksOnDay = taskProvider.getTasksByDay(_selectedDay);

    final List<TaskModel> filtered = _filterStatus == null
        ? List<TaskModel>.from(tasksOnDay)
        : tasksOnDay.where((t) => t.effectiveStatus == _filterStatus).toList();

    _applySorting(filtered);
    return filtered;
  }

  void _applySorting(List<TaskModel> tasks) {
    switch (_sortOption) {
      case TaskSortOption.newest:
        tasks.sort((a, b) => b.deadline.compareTo(a.deadline));
        break;
      case TaskSortOption.oldest:
        tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
        break;
      case TaskSortOption.priority:
        tasks.sort((a, b) {
          if (a.isHighPriority == b.isHighPriority) {
            return b.deadline.compareTo(a.deadline);
          }
          return a.isHighPriority ? -1 : 1;
        });
        break;
      case TaskSortOption.alphabet:
        tasks.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
    }
  }
}