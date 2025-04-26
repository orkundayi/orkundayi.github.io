import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutech/providers/language_provider.dart';
import 'package:flutech/providers/theme_provider.dart';
import 'package:flutech/routes/app_routes.dart';
import 'package:flutech/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart'; // Web URL için

void main() {
  // Web URL'lerdeki #'yi kaldır
  setPathUrlStrategy();

  // Flutter web performans optimizasyonları
  // Araçları devre dışı bırak
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // Web performansı için
      themeMode: themeProvider.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Lokalizasyon
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: languageProvider.locale,

      routerConfig: appRouter,

      // Web performansı için ek ayarlar
      builder: (context, child) {
        // Sayfa geçişlerinde yumuşak scroll davranışı
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            physics: const ClampingScrollPhysics(),
            platform: TargetPlatform.macOS, // Daha yumuşak scrolling
          ),
          child: child!,
        );
      },
    );
  }
}
