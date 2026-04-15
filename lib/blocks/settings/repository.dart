import 'package:shared_preferences/shared_preferences.dart';

import '../../services/db_service.dart';

class SettingsRepository {
  static const String _langKey = 'selected_language';

  Future<void> saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, lang);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey) ?? 'UK';
  }

  Future<void> clearAllData() async {
    // await Future.delayed(const Duration(milliseconds: 300));
    await DatabaseService.instance.deleteAllData();
  }
}