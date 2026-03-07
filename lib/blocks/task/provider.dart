import 'package:flutter/material.dart';

import '../category/model.dart';

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
}