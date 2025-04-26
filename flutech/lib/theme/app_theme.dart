import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light theme colors
  static final ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0066FF), // Vibrant blue
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6), // Teal
    onSecondary: Colors.black,
    tertiary: Color(0xFF6B38FB), // Purple
    onTertiary: Colors.white,
    error: Color(0xFFB00020),
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF1C1B1F),
    surfaceContainerHighest: Color(0xFFF4F4F4),
    outline: Color(0xFFBDBDBD),
  );

  // Dark theme colors - Mavi tonlarına güncellenmiş koyu tema
  static final ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF1976D2), // Ana mavi (Material Blue 700)
    onPrimary: Colors.white,
    secondary: Color(0xFF42A5F5), // Açık mavi (Material Blue 400)
    onSecondary: Colors.white,
    tertiary: Color(0xFF0D47A1), // Koyu mavi (Material Blue 900)
    onTertiary: Colors.white,
    error: Color(0xFFCF6679),
    onError: Colors.black,
    surface: Color(0xFF121212), // Daha koyu arka plan
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF1E1E1E), // Kart ve container'lar için arka plan
    outline: Color(0xFF8E8E8E),
    background: Color(0xFF0F0F0F), // En koyu arka plan
    onBackground: Colors.white,
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: _lightColorScheme.primary,
        foregroundColor: _lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        side: BorderSide(color: _lightColorScheme.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
      ),
    ),
  );

  // Dark theme - Mavi tonlarına güncellenmiş koyu tema
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
    cardTheme: CardTheme(
      color: _darkColorScheme.surfaceContainerHighest,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    scaffoldBackgroundColor: _darkColorScheme.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: _darkColorScheme.primary,
        foregroundColor: _darkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkColorScheme.primary,
        side: BorderSide(color: _darkColorScheme.primary, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkColorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
      ),
    ),
    // Ek bileşen temaları
    dialogTheme: DialogTheme(
      backgroundColor: _darkColorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: _darkColorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
  );
}
