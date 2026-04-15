import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planbee/screens/settings/settings_card.dart';
import 'package:provider/provider.dart';
import 'package:planbee/core/theme/colors_extension.dart';
import 'package:planbee/core/utils/app_padding.dart';
import '../../blocks/settings/provider.dart';
import '../../generated/l10n.dart';
import 'controller.dart';
import 'language_switcher.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final $ = S.of(context);
    final theme = Theme.of(context);
    final settingsProvider = context.watch<SettingsProvider>();
    final customColors = theme.extension<AppColorsExtension>();

    final controller = SettingsController(context, settingsProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.screen(context).copyWith(bottom: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // General
              SettingsCard(
                title: $.general,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text($.language, style: theme.textTheme.bodyLarge),
                    LanguageSwitcher(
                      currentLang: settingsProvider.language,
                      onChanged: controller.onLanguageChanged,
                      customColors: customColors!,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Data Management
              SettingsCard(
                title: $.dataManagement,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text($.clearAllData, style: theme.textTheme.bodyLarge),
                    TextButton(
                      onPressed: controller.onClearDataPressed,
                      child: Text(
                        $.clear,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



