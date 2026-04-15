import 'package:flutter/material.dart';
import 'package:planbee/generated/l10n.dart';

import 'model.dart';

class CategoryProvider extends ChangeNotifier{

  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Health', icon: Icons.favorite, iconColor: Colors.blue),
    CategoryModel(id: '2', name: 'Personal', icon: Icons.person, iconColor: Colors.blue),
    CategoryModel(id: '3', name: 'Home', icon: Icons.home, iconColor: Colors.blue),
    CategoryModel(id: '4', name: 'Work', icon: Icons.work, iconColor: Colors.blue),
    CategoryModel(id: '5', name: 'Study', icon: Icons.school, iconColor: Colors.blue),
    CategoryModel(id: '6', name: 'Finance', icon: Icons.brightness_7, iconColor: Colors.blue),
    CategoryModel(id: '7', name: 'No Category', icon: Icons.not_interested, iconColor: Colors.blue),
  ];

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  void addCategory(CategoryModel newCategory) {
    _categories.add(newCategory);
    notifyListeners();
  }

}

extension CategoryL10n on String {
  String toCategoryName(BuildContext context) {
    final $ = S.of(context);
    return switch (this) {
      '1' => $.health,
      '2' => $.personal,
      '3' => $.home,
      '4' => $.work,
      '5' => $.study,
      '6' => $.finance,
      _ => $.noCategory,
    };
  }
}