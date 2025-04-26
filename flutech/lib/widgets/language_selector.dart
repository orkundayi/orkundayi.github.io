import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutech/providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final bool isCompact;

  const LanguageSelector({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLocale = languageProvider.locale;

    return PopupMenuButton<Locale>(
      tooltip: AppLocalizations.of(context).language,
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      offset: const Offset(0, 10),
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFlagIcon(currentLocale.languageCode),
          if (!isCompact) const SizedBox(width: 4),
          if (!isCompact) Icon(Icons.arrow_drop_down),
        ],
      ),
      onSelected: (Locale locale) {
        languageProvider.setLocale(locale);
      },
      itemBuilder: (context) => languageProvider.supportedLocales.map((locale) {
        final isSelected = currentLocale.languageCode == locale.languageCode;
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            children: [
              _buildFlagIcon(locale.languageCode),
              const SizedBox(width: 12),
              Text(
                languageProvider.getDisplayLanguage(locale),
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colorScheme.primary : null,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  Icons.check,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFlagIcon(String languageCode) {
    // Simple flag representation using text, you could replace with actual flag images
    switch (languageCode) {
      case 'en':
        return Text('🇬🇧', style: TextStyle(fontSize: isCompact ? 18 : 20));
      case 'tr':
        return Text('🇹🇷', style: TextStyle(fontSize: isCompact ? 18 : 20));
      default:
        return Icon(Icons.language);
    }
  }
}
