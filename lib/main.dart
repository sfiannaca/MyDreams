import 'dart:io';
import 'package:diaryofdreams/l10n/l10n.dart';
import 'package:diaryofdreams/providers/filter_provider.dart';
import 'package:diaryofdreams/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:diaryofdreams/providers/db_provider.dart';
import 'package:diaryofdreams/styles.dart';
import 'package:diaryofdreams/providers/theme_provider.dart';
import 'package:diaryofdreams/ui/layout/nav_tabs.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    const windowSize = Size(468, 768);
    const maxWindowSize = Size(800, 2160);
    Rect initialFrame = Rect.fromPoints(
        const Offset(0, 0), windowSize.bottomRight(Offset.zero));
    setWindowTitle('Diary of Dreams');
    setWindowFrame(initialFrame);
    setWindowMinSize(windowSize);
    setWindowMaxSize(maxWindowSize);
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  ThemeProvider themeProvider = ThemeProvider();
  DbProvider dbProvider = DbProvider();
  FilterProvider filterProvider = FilterProvider();
  SettingsProvider settingProvider = SettingsProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => themeProvider..initialize()),
          ChangeNotifierProvider(create: (_) => filterProvider),
          ChangeNotifierProvider(create: (_) => dbProvider),
          ChangeNotifierProvider(create: (_) => settingProvider..initialize()),
        ],
        child:
            Consumer<ThemeProvider>(builder: (BuildContext context, value, _) {
          var currLocale =
              Provider.of<SettingsProvider>(context, listen: true).locale;
          initializeDateFormatting(currLocale);

          return MaterialApp(
            locale: Locale(currLocale),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData('light', context),
            darkTheme: Styles.themeData('dark', context),
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            home: const NavTabs(),
          );
        }));
  }
}
