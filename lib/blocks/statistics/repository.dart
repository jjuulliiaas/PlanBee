import 'package:flutter/material.dart';

import '../../blocks/task/model.dart';
import '../category/model.dart';

class StatsRepository {
  Map<DateTime, int> getHeatmapDatasets(List<TaskModel> tasks) {
    final Map<DateTime, int> datasets = {};
    final completedTasks = tasks.where((t) => t.status == TaskStatus.completed);

    for (var task in completedTasks) {
      final date = DateTime(task.deadline.year, task.deadline.month, task.deadline.day);
      datasets[date] = (datasets[date] ?? 0) + 1;
    }
    return datasets;
  }

  int calculateGoldenHour(List<TaskModel> tasks) {
    final completedTasks = tasks.where((t) => t.status == TaskStatus.completed).toList();
    if (completedTasks.isEmpty) return -1;

    final hourCounts = <int, int>{};
    for (var task in completedTasks) {
      hourCounts[task.deadline.hour] = (hourCounts[task.deadline.hour] ?? 0) + 1;
    }

    return hourCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  List<double> getWeeklyActivity(List<TaskModel> tasks) {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.subtract(Duration(days: 6 - index));
      final dayTasks = tasks.where((t) =>
      t.deadline.year == day.year &&
          t.deadline.month == day.month &&
          t.deadline.day == day.day
      ).toList();

      if (dayTasks.isEmpty) return 0.0;
      final completed = dayTasks.where((t) => t.status == TaskStatus.completed).length;
      return (completed / dayTasks.length) * 100;
    });
  }

  List<MapEntry<String, double>> getDynamicWeeklyActivity(List<TaskModel> tasks) {
    final now = DateTime.now();
    final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      final dayName = weekDays[date.weekday - 1];

      final dayTasks = tasks.where((t) =>
      t.deadline.year == date.year &&
          t.deadline.month == date.month &&
          t.deadline.day == date.day
      ).toList();

      double percentage = 0.0;
      if (dayTasks.isNotEmpty) {
        final completed = dayTasks.where((t) => t.isCompleted).length;
        percentage = (completed / dayTasks.length) * 100;
      }

      return MapEntry(dayName, percentage);
    });
  }

  List<Map<String, dynamic>> getCategoryProgress(List<TaskModel> tasks) {
    if (tasks.isEmpty) return [];

    final Map<String, List<TaskModel>> groupedById = {};
    final Map<String, CategoryModel?> categoryObjects = {};

    for (var task in tasks) {
      final catId = task.category?.id ?? 'general';
      groupedById.putIfAbsent(catId, () => []).add(task);

      if (!categoryObjects.containsKey(catId)) {
        categoryObjects[catId] = task.category;
      }
    }

    final List<Map<String, dynamic>> result = [];

    for (var entry in groupedById.entries) {
      final catId = entry.key;
      final list = entry.value;
      final category = categoryObjects[catId];

      final completed = list.where((t) => t.isCompleted).length;
      final progress = completed / list.length;

      result.add({
        'name': category?.name ?? 'General',
        'icon': category?.icon ?? Icons.category_rounded,
        'color': category?.iconColor,
        'progress': progress,
      });
    }
    return result;
  }

  int getYesterdayCompletedCount(List<TaskModel> tasks) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return tasks.where((t) =>
    t.isCompleted &&
        t.deadline.year == yesterday.year &&
        t.deadline.month == yesterday.month &&
        t.deadline.day == yesterday.day
    ).length;
  }

  List<double> getMonthlyActivity(List<TaskModel> tasks) {
    final now = DateTime.now();
    return List.generate(12, (index) {
      final month = index + 1;
      final monthTasks = tasks.where((t) =>
      t.deadline.year == now.year && t.deadline.month == month
      ).toList();

      if (monthTasks.isEmpty) return 0.0;

      final completed = monthTasks.where((t) => t.isCompleted).length;
      return completed / monthTasks.length;
    });
  }

  /// Use Records to return extend stats (Dart 3 feature)
  ({int total, int active, double rate}) getGeneralStats(List<TaskModel> tasks) {
    if (tasks.isEmpty) return (total: 0, active: 0, rate: 0.0);

    final active = tasks.where((t) => !t.isCompleted).length;
    final completed = tasks.length - active;

    return (
    total: tasks.length,
    active: active,
    rate: completed / tasks.length,
    );
  }
}