import 'package:flutter/material.dart';
import 'package:planbee/blocks/settings/repository.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository = SettingsRepository();
  String _language = 'UA';

  String get language => _language;

  Future<void> updateLanguage(String lang) async {
    _language = lang;
    await _repository.saveLanguage(lang);
    notifyListeners();
  }

  Future<void> resetAllData() async {
    await _repository.clearDatabase();
    notifyListeners();
  }
}