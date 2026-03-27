class SettingsRepository {
  // Імітація збереження мови
  Future<void> saveLanguage(String lang) async {
    // await prefs.setString('language', lang);
  }

  // Очищення всіх даних із TaskProvider або локальної БД
  Future<void> clearDatabase() async {
    // Логіка видалення файлів БД або очищення Hive/Sqflite
    await Future.delayed(const Duration(milliseconds: 500));
  }
}