import 'package:flutter/material.dart';

import '../../blocks/settings/provider.dart';
import '../../core/theme/dialog_helper.dart';

class SettingsController {
  final BuildContext context;
  final SettingsProvider provider;

  SettingsController(this.context, this.provider);

  void onLanguageChanged(String lang) {
    provider.updateLanguage(lang);
  }

  void onClearDataPressed() {
    DialogsHelper.showClearDataDialog(
      context: context,
      onConfirm: () async {
        await provider.resetAllData();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All data cleared 🐝')),
          );
        }
      },
    );
  }
}