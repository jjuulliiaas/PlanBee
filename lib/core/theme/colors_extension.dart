import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.success,
    required this.successSoft,
    required this.yellow,
});

  final Color success;
  final Color successSoft;
  final Color yellow;

  @override
  AppColorsExtension copyWith({
    Color? success,
    Color? successSoft,
    Color? yellow
}) {
    return AppColorsExtension(
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      yellow: yellow ?? this.yellow
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      successSoft: Color.lerp(successSoft, other.successSoft, t)!,
      yellow: Color.lerp(yellow, other.yellow, t)!,
    );
  }
}

extension ThemeDataHelpers on ThemeData {
  AppColorsExtension get appColors => extension<AppColorsExtension>()!;
}