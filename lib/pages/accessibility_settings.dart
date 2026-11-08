
import 'package:flutter/material.dart';

class AccessibilitySettings extends ChangeNotifier {
  double textSize = 18;
  bool highContrast = false;
  String selectedLanguage = 'English';

  void updateTextSize(double newSize) {
    textSize = newSize;
    notifyListeners();
  }

  void updateHighContrast(bool value) {
    highContrast = value;
    notifyListeners();
  }

  void updateLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }
}

// One shared settings object for the whole website.
final accessibilitySettings = AccessibilitySettings();
