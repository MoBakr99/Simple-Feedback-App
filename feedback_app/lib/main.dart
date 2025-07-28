// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Screens/home_screen.dart';
import 'Models/feed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive for local storage
  await Hive.initFlutter();
  Hive.registerAdapter(FeedAdapter());
  await Hive.openBox<Feed>('feedbackBox');
  await Hive.openBox('settings');
  runApp(const FeedbackApp());
}

class FeedbackApp extends StatefulWidget {
  const FeedbackApp({super.key});

  @override
  State<FeedbackApp> createState() => _FeedbackAppState();
}

class _FeedbackAppState extends State<FeedbackApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    final themeString =
        Hive.box('settings').get('theme', defaultValue: 'system');
    _themeMode = _getThemeModeFromString(themeString);
  }

  void _updateTheme(ThemeMode newMode) {
    setState(() => _themeMode = newMode);
    Hive.box('settings').put('theme', newMode.name);
  }

  ThemeMode _getThemeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Feedback App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomeScreen(
        themeMode: _themeMode,
        onThemeChange: _updateTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
