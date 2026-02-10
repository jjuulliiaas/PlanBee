import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planbee/core/theme/colors_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  /// Design Tokens

  // Colors

  static Color get _accent => const Color(0xFF4F46E5);
  static Color get _accentSoft => const Color(0xFFEEF2FF);

  static Color get _primaryBackground => const Color(0xFFF8F9FB);
  static Color get _white => const Color(0xFFFFFFFF);        // secondary background

  static Color get _primaryText => const Color(0xFF0F172A);
  static Color get _secondaryText => const Color(0xFF64748B);
  static Color get _hintDisabled => const Color(0xFF94A3B8);

  // Semantic colors (statuses)

  static Color get _successGreen => const Color(0xFF22C55E);
  static Color get _successGreenSoft => const Color(0xFFDCFCE7);
  static Color get _errorRed => const Color(0xFFEF4444);
  static Color get _yellow => const Color(0xFFE5BB46);

  // Sizes and forms

  static double get _radiusSmall => 10.0.r;
  static double get _radiusMedium => 12.0.r;
  static double get _radiusLarge => 16.0.r;

  /// Color Scheme

  static ColorScheme get _lightColorScheme => ColorScheme(
      brightness: Brightness.light,

      primary: _accent,
      onPrimary: _white,
      primaryContainer: _accentSoft,
      onPrimaryContainer: _accent,

      secondary: _secondaryText,
      onSecondary: _white,
      secondaryContainer: _primaryBackground,
      onSecondaryContainer: _primaryText,

      surface: _white,
      onSurface: _primaryText,

      error: _errorRed,
      onError: _white,

      outline: _hintDisabled,
      // outlineVariant: const Color(0xFFE2E8F0),


  );

  static TextTheme _textTheme(ColorScheme colorScheme) {
    const String fontName = 'Manrope';

    TextStyle style({
      required double size,
      required FontWeight weight,
      Color? color,
      double? height,
      double? letterSpacing
    }) {
      return TextStyle(
        fontSize: size.sp,
        fontWeight: weight,
        color: color ?? _primaryText,
        height: height,
        letterSpacing: letterSpacing
      );
    }

    return TextTheme(

      // Big headers
      headlineLarge: style(size: 30, weight: FontWeight.w600, color: _primaryText),     // task title
      headlineMedium: style(size: 24, weight: FontWeight.w600, color: _primaryText),    // optional screen title
      headlineSmall: style(size: 20, weight: FontWeight.w600, color: _primaryText),     // screen/section title

      // Body text
      bodyLarge: style(size: 16, weight: FontWeight.w500,),   // categories titles
      bodyMedium: style(size: 14, weight: FontWeight.w500,),
      bodySmall: style(size: 12, weight: FontWeight.w400,),

      // Special labels (chips and statuses)
      labelLarge: style(size: 10, weight: FontWeight.w400,),
      labelSmall: style(size: 8, weight: FontWeight.w400,),


    );
}

  static ThemeData get lightTheme {
    final colorScheme = _lightColorScheme;
    final textTheme = _textTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: _primaryBackground,

      extensions: <ThemeExtension<dynamic>>[
        AppColorsExtension(
            success: _successGreen,
            successSoft: _successGreenSoft,
            yellow: _yellow
        )
      ],

      // AppBar
      appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: _primaryText),
      titleTextStyle: textTheme.headlineSmall,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),

      cardTheme: CardThemeData(
        color: _white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLarge),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          foregroundColor: _white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusMedium),
          ),
          textStyle: textTheme.bodyMedium,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _white,
        contentPadding: const EdgeInsets.all(16),
        hintStyle: TextStyle(color: _hintDisabled),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radiusMedium),
          borderSide: BorderSide(color: _accent, width: 1.5),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        shape: const CircleBorder(),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _successGreen;
          }
          return Colors.transparent;
        }),
        side: WidgetStateBorderSide.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return BorderSide.none;
          return BorderSide(color: _hintDisabled, width: 1.5);
        }),
        checkColor: WidgetStateProperty.all(_white),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: _white,
        selectedColor: _accentSoft,
        disabledColor: _hintDisabled,
        labelStyle: textTheme.labelSmall,
        checkmarkColor: _accent,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusSmall),
        ),
        side: WidgetStateBorderSide.resolveWith((states) {
          if(states.contains(WidgetState.selected)) return BorderSide.none;
          return BorderSide(color: _hintDisabled);
        }),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return _accent;
          return _white;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return _accentSoft;
          return _hintDisabled;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _accent,
        foregroundColor: _white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusLarge),
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _white,
        modalBackgroundColor: _white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(_radiusLarge)
          ),
        ),
      ),

      iconTheme: IconThemeData(
        color: _accent,
        size: 20.r,
      ),
    );
  }

}