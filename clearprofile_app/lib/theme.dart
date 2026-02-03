import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;
}

extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

class AppColors {
  // Provided Palette
  // Ultra-Premium Black & White Palette
  static const primary = Color(0xFF000000); // Pure Black
  static const surface = Color(0xFF050505); // Near Black
  static const accent = Color(0xFFFFFFFF); // Pure White Glow
  static const success = Color(0xFF4ADE80); // Vibrant Green (High Contrast)
  static const warning = Color(0xFFFACC15); // Vibrant Yellow
  static const error = Color(0xFFF87171); // Soft Red
  static const divider = Color(0xFF262626); // Dark Gray
  
  // Derived / Additional
  static const onPrimary = Colors.black;
  static const onSurface = Color(0xFFF8FAFC); // White text
  static const onSurfaceVariant = Color(0xFFA3A3A3); // Neutral Grey
  static const cardBackground = Color(0xFF0A0A0A); // Deepest Gray
}

class FontSizes {
  static const double h1 = 28.0;
  static const double h2 = 22.0;
  static const double h3 = 18.0;
  static const double body = 15.0;
  static const double caption = 12.0;
}

ThemeData get appTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.surface,
  primaryColor: AppColors.primary,
  
  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: Colors.white,
    secondary: AppColors.success,
    onSecondary: Colors.white,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.divider,
  ),

  dividerTheme: const DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.surface,
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    titleTextStyle: GoogleFonts.inter(
      fontSize: FontSizes.h3,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
      letterSpacing: 0.5,
    ),
    iconTheme: const IconThemeData(color: AppColors.onSurface),
  ),

  cardTheme: CardThemeData(
    color: AppColors.cardBackground,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      side: const BorderSide(color: AppColors.divider, width: 1),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardBackground,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.accent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    hintStyle: GoogleFonts.inter(
      color: AppColors.onSurfaceVariant,
      fontSize: FontSizes.body,
    ),
    labelStyle: GoogleFonts.inter(
      color: AppColors.onSurface,
      fontSize: FontSizes.body,
    ),
  ),

  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: FontSizes.h1,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
      letterSpacing: -0.5,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: FontSizes.h2,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
      letterSpacing: -0.25,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: FontSizes.h3,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurface,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.body,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
      letterSpacing: 0.15,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.body,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: FontSizes.caption,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurfaceVariant,
      letterSpacing: 0.4,
    ),
  ),
  
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.accent,
    selectionColor: AppColors.accent.withOpacity(0.3),
    selectionHandleColor: AppColors.accent,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.black, // Fix default text color to Black
      elevation: 0,
      textStyle: GoogleFonts.inter(
        fontSize: FontSizes.body,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.onSurface,
      side: const BorderSide(color: AppColors.divider),
      textStyle: GoogleFonts.inter(
        fontSize: FontSizes.body,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),
  ),
);
