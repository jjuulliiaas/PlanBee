import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../blocks/category/model.dart';
import '../blocks/task/model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('planbee.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        icon_code INTEGER NOT NULL,
        color_value INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        category_id TEXT,
        created_at TEXT NOT NULL,
        deadline TEXT NOT NULL,
        is_high_priority INTEGER NOT NULL,
        time_spent_ms INTEGER,
        status TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL
      )
    ''');
  }

  Future<void> insertCategory(CategoryModel category) async {
    final db = await instance.database;
    await db.insert('categories', category.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await instance.database;
    final result = await db.query('categories');
    return result.map((json) => CategoryModel.fromMap(json)).toList();
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await instance.database;

    if (task.category != null) {
      await insertCategory(task.category!);
    }

    await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await instance.database;

    final result = await db.rawQuery('''
    SELECT tasks.*, 
           categories.name as cat_name, 
           categories.icon_code as cat_icon, 
           categories.color_value as cat_color
    FROM tasks
    LEFT JOIN categories ON tasks.category_id = categories.id
    ORDER BY tasks.deadline ASC
  ''');

    return result.map((json) {
      CategoryModel? category;

      if (json['category_id'] != null && json['cat_name'] != null) {
        category = CategoryModel(
          id: json['category_id'] as String,
          name: json['cat_name'] as String,
          icon: IconData(json['cat_icon'] as int, fontFamily: 'MaterialIcons'),
          iconColor: Color(json['cat_color'] as int),
        );
      }

      return TaskModel.fromMap(json, category: category);
    }).toList();
  }

  Future<void> updateTaskStatus(String id, String status) async {
    final db = await instance.database;
    await db.update(
      'tasks',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTask(String id) async {
    final db = await instance.database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

}