import 'package:flutter/material.dart';

import '../category/model.dart';
import 'model.dart';

class TaskProvider extends ChangeNotifier{
  String _title = '';
  String _description = '';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isHighPriority = false;
  CategoryModel? _selectedCategory;
  bool _isLoading = false;
  CategoryModel? _tempSelectedCategory;   // draft of category choice

  String get title => _title;
  String get description => _description;
  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  bool get isHighPriority => _isHighPriority;
  CategoryModel? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  CategoryModel? get tempSelectedCategory => _tempSelectedCategory;

  bool get canSave {
    return title.trim().isNotEmpty &&
    selectedCategory != null &&
    selectedDate != null &&
    selectedTime != null;
  }

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    notifyListeners();
  }

  set selectedTime(TimeOfDay? value) {
    _selectedTime = value;
    notifyListeners();
  }

  set isHighPriority(bool value) {
    _isHighPriority = value;
    notifyListeners();
  }

  set selectedCategory(CategoryModel? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set tempSelectedCategory(CategoryModel? value) {
    _tempSelectedCategory = value;
    notifyListeners();
  }

  set tasks(List<TaskModel> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  DateTime? get fullDeadline {
    if (_selectedDate == null || _selectedTime == null) {
      return null;
    }
    return DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
  }

  void reset() {
    _selectedDate = null;
    _selectedTime = null;
    _selectedCategory = null;
    _isHighPriority = false;
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    _tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
    notifyListeners();
  }

  void updateTaskStatusLocally(String id, TaskStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  void updateTaskInList(TaskModel updatedTask) {
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
      notifyListeners();
    }
  }

  void loadTaskData(TaskModel task) {
    _title = task.title;
    _description = task.description ?? '';
    _selectedDate = task.deadline;
    _selectedTime = TimeOfDay.fromDateTime(task.deadline);
    _selectedCategory = task.category;
    _isHighPriority = task.isHighPriority;

    notifyListeners();
  }

  List<TaskModel> getTasksByDay(DateTime day) {
    return _tasks.where((t) =>
    t.deadline.year == day.year &&
        t.deadline.month == day.month &&
        t.deadline.day == day.day
    ).toList();
  }

  void deleteTaskLocally(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}