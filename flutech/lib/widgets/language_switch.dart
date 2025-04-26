import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutech/providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      tooltip: 'Change language',
      onSelected: (String languageCode) {
        localeProvider.setLocale(Locale(languageCode));
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'en',
          child: Row(
            children: [
              if (isEnglish) const Icon(Icons.check, size: 18) else const SizedBox(width: 18),
              const SizedBox(width: 8),
              Text(l10n.languageEn),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'tr',
          child: Row(
            children: [
              if (!isEnglish) const Icon(Icons.check, size: 18) else const SizedBox(width: 18),
              const SizedBox(width: 8),
              Text(l10n.languageTr),
            ],
          ),
        ),
      ],
    );
  }
}
