import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier{
  String _title = '';
  String _description = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isHighPriority = false;
  String? _categoryId;
  bool _isLoading = false;

  String get title => _title;
  String get description => _description;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  bool get isHighPriority => _isHighPriority;
  String? get categoryId => _categoryId;
  bool get isLoading => _isLoading;

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  set selectedDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  set selectedTime(TimeOfDay value) {
    _selectedTime = value;
    notifyListeners();
  }

  set isHighPriority(bool value) {
    _isHighPriority = value;
    notifyListeners();
  }

  set categoryId(String value) {
    _categoryId = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  DateTime get fullDeadline {
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
  }

}