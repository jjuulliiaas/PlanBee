import 'package:flutter/material.dart';
import 'package:planbee/blocks/settings/repository.dart';

import '../task/provider.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository = SettingsRepository();
  String _language = 'UA';

  final TaskProvider taskProvider;

  SettingsProvider({required this.taskProvider}) {
    _loadSettings();
  }

  String get language => _language;

  Future<void> _loadSettings() async {
    _language = await _repository.getLanguage();
    notifyListeners();
  }

  Future<void> updateLanguage(String lang) async {
    if (_language == lang) return;
    _language = lang;
    await _repository.saveLanguage(lang);
    notifyListeners();
  }

  Future<void> resetData() async {
    try {
      // 1. Видаляємо фізично з бази
      await _repository.clearAllData();

      // 2. Скидаємо стан у провайдері тасок
      taskProvider.resetState();

      // 3. Можна додати повідомлення про успіх або лог
      debugPrint("All honey data cleared successfully 🐝");

      notifyListeners();
    } catch (e) {
      debugPrint("Error clearing data: $e");
    }
  }
}