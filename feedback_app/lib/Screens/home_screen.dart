// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'give_feedback_screen.dart';
import 'feedbacks_screen.dart';

class HomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChange;
  const HomeScreen(
      {super.key, required this.themeMode, required this.onThemeChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback App'),
        // centerTitle: true,
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(
              widget.themeMode == ThemeMode.system
                  ? Icons.brightness_6
                  : widget.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
            ),
            onSelected: widget.onThemeChange,
            tooltip: 'Theme',
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Row(
                  children: [
                    Icon(Icons.brightness_6),
                    SizedBox(width: 10),
                    Text('System')
                  ],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Row(
                  children: [
                    Icon(Icons.light_mode),
                    SizedBox(width: 10),
                    Text('Light')
                  ],
                ),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: Row(
                  children: [
                    Icon(Icons.dark_mode),
                    SizedBox(width: 10),
                    Text('Dark')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome\nWe're Happy to Know Your Thoughts!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackScreen()),
                );
              },
              child: const Text(
                'Give Feedback',
                textScaler: TextScaler.linear(1.2),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          heroTag: 'FeedbacksBtn',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedbacksScreen()),
            );
          },
          tooltip: 'View Feedbacks',
          shape: const CircleBorder(),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.feedback),
        ),
      ),
    );
  }
}
