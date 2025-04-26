import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const String appName = 'Flutter Developer Portfolio';

  static const List<Locale> supportedLocales = [
    Locale('tr'), // Turkish
    Locale('en'), // English
  ];

  static const String email = 'orkundayi@flutech.org';
  static const String github = 'https://github.com/orkundayi';
  static const String linkedin = 'https://linkedin.com/in/orkundayi';

  // Navigation items for web header
  static final List<NavItem> navItems = [
    NavItem(title: 'home', route: '/'),
    NavItem(title: 'about', route: '/about'),
    NavItem(title: 'projects', route: '/projects'),
    NavItem(title: 'contact', route: '/contact'),
  ];
}

// Navigation item class for web header
class NavItem {
  final String title;
  final String route;

  const NavItem({required this.title, required this.route});
}

class AppTheme {
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade700,
      onPrimary: Colors.white,
      secondary: Colors.orange,
      surface: Colors.white,
      onSurface: Colors.grey.shade900,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 18,
        color: Colors.black.withOpacity(0.8),
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.black.withOpacity(0.8),
        height: 1.5,
      ),
    ),
    // Rest of theme data...
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade400,
      onPrimary: Colors.white,
      secondary: Colors.orange.shade300,
      surface: Color(0xFF1E1E1E),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 18,
        color: Colors.white.withOpacity(0.8),
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 16,
        color: Colors.white.withOpacity(0.8),
        height: 1.5,
      ),
    ),
    // Rest of theme data...
  );
}
