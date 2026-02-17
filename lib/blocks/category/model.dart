import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color iconColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
});

  static List<CategoryModel> get mockCategories => [
    CategoryModel(id: '1', name: 'Health', icon: Icons.favorite, iconColor: Colors.blue),
    CategoryModel(id: '2', name: 'Personal', icon: Icons.person, iconColor: Colors.blue),
    CategoryModel(id: '3', name: 'Home', icon: Icons.home, iconColor: Colors.blue),
    CategoryModel(id: '4', name: 'Work', icon: Icons.work, iconColor: Colors.blue),
    CategoryModel(id: '5', name: 'Study', icon: Icons.school, iconColor: Colors.blue),
    CategoryModel(id: '6', name: 'Finance', icon: Icons.brightness_7, iconColor: Colors.blue),
    CategoryModel(id: '7', name: 'No Category', icon: Icons.not_interested, iconColor: Colors.blue),
  ];
}