import 'package:flutter/material.dart';
import '../../blocks/task/provider.dart';
import 'repository.dart';

class StatsProvider extends ChangeNotifier {
  final TaskProvider taskProvider;
  final StatsRepository _repository = StatsRepository();

  bool _isMotivationHidden = false;
  DateTime _lastUpdateDate = DateTime.now();

  StatsProvider(this.taskProvider) {
    taskProvider.addListener(_handleTaskUpdate);
  }

  void _handleTaskUpdate() {
    _checkAndResetMotivation();
    notifyListeners();
  }

  void _checkAndResetMotivation() {
    final now = DateTime.now();
    if (now.day != _lastUpdateDate.day ||
        now.month != _lastUpdateDate.month ||
        now.year != _lastUpdateDate.year) {
      _isMotivationHidden = false;
      _lastUpdateDate = now;
    }
  }

  ({int total, int active, double rate}) get mainStats =>
      _repository.getGeneralStats(taskProvider.tasks);

  int get totalCount => mainStats.total;
  int get activeCount => mainStats.active;
  double get completionRate => mainStats.rate;

  List<double> get monthlyActivity =>
      _repository.getMonthlyActivity(taskProvider.tasks);

  List<MapEntry<String, double>> get weeklyData =>
      _repository.getDynamicWeeklyActivity(taskProvider.tasks);

  Map<DateTime, int> get heatmapDatasets =>
      _repository.getHeatmapDatasets(taskProvider.tasks);

  List<Map<String, dynamic>> get categoryProgress =>
      _repository.getCategoryProgress(taskProvider.tasks);

  int get yesterdayCompletedCount =>
      _repository.getYesterdayCompletedCount(taskProvider.tasks);

  bool get isMotivationHidden => _isMotivationHidden;

  String get goldenHour {
    final hour = _repository.calculateGoldenHour(taskProvider.tasks);
    if (hour == -1) return "No data";
    return "${hour.toString().padLeft(2, '0')}:00 - ${(hour + 1).toString().padLeft(2, '0')}:00";
  }

  void hideMotivation() {
    _isMotivationHidden = true;
    notifyListeners();
  }

  @override
  void dispose() {
    taskProvider.removeListener(_handleTaskUpdate);
    super.dispose();
  }
}