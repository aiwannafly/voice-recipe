import 'package:flutter/material.dart';
import 'package:voice_recipe/screens/home_screen.dart';
import 'package:voice_recipe/themes/dark_theme_provider.dart';

import 'config.dart';

class VoiceRecipeApp extends StatefulWidget {
  const VoiceRecipeApp({super.key});

  @override
  State<VoiceRecipeApp> createState() => _VoiceRecipeAppState();
}

class _VoiceRecipeAppState extends State<VoiceRecipeApp> {
  final DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  final lightTheme = ThemeData(
      primarySwatch: const MaterialColor(0xFFf07800, Config.colorScheme),
      bottomAppBarTheme: BottomAppBarTheme(
          color: const MaterialColor(0xFFf07800, Config.colorScheme)));
  final darkTheme = ThemeData(
      bottomAppBarTheme: const BottomAppBarTheme(
          color: const MaterialColor(0xFFf07800, Config.colorScheme)),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch:
                  const MaterialColor(0xFFf07800, Config.colorScheme))
          .copyWith(
              background: const MaterialColor(0xff000000, Config.colorScheme))
      // primarySwatch: const MaterialColor(0xff000000, Config.colorScheme)
      );

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.isDarkTheme =
        true; //await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: Config.appName,
            home: const Home(),
            theme: Config.darkModeOn ? darkTheme : lightTheme
    );
  }
}
