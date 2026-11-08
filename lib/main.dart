
import 'package:flutter/material.dart';
import 'pages/accessibility_settings.dart';
import 'pages/home_page.dart';
import 'pages/booking.dart';
import 'pages/accessibility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessibilitySettings,
      builder: (context, child) {
        final settings = accessibilitySettings;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CareConnect',

          theme: ThemeData(
            primaryColor: const Color(0xFF008C95),
            colorScheme: settings.highContrast
                ? const ColorScheme.highContrastLight()
                : ColorScheme.fromSeed(
                    seedColor: const Color(0xFF008C95),
                  ),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),

          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(settings.textSize / 18),
              ),
              child: child!,
            );
          },

          home: const HomePage(),
        );
      },
    );
  }
}
