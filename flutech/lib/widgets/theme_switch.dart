import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutech/providers/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context);
    final isDarkMode = themeProvider.isDarkMode;

    return IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      tooltip: isDarkMode ? l10n.lightMode : l10n.darkMode,
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
