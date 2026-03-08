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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon_code': icon.codePoint,
      'color_value': iconColor.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      icon: IconData(
        map['icon_code'] as int,
        fontFamily: 'MaterialIcons',
      ),
      iconColor: Color(map['color_value'] as int),
    );
  }
}