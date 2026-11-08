
import 'package:flutter/material.dart';
import 'accessibility_settings.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  Color get backgroundColor =>
      accessibilitySettings.highContrast ? Colors.black : Colors.white;

  Color get textColor =>
      accessibilitySettings.highContrast ? Colors.white : Colors.black87;

  Color get cardColor => accessibilitySettings.highContrast
      ? const Color(0xFF222222)
      : const Color(0xFFE8F6F6);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessibilitySettings,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Accessibility Settings'),
            backgroundColor: const Color(0xFF008C95),
            foregroundColor: Colors.white,
          ),
          body: Container(
            color: backgroundColor,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 750),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Make the website easier to use',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Adjust the settings according to your needs.',
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // TEXT SIZE
                      Card(
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Text Size',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Adjust the text to make it easier to read.',
                                style: TextStyle(color: textColor),
                              ),

                              Slider(
                                value: accessibilitySettings.textSize,
                                min: 14,
                                max: 28,
                                divisions: 7,
                                label:
                                    '${accessibilitySettings.textSize.round()}',
                                activeColor: const Color(0xFF008C95),
                                onChanged: (value) {
                                  accessibilitySettings.updateTextSize(value);
                                },
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Smaller',
                                    style: TextStyle(color: textColor),
                                  ),
                                  Text(
                                    'Larger',
                                    style: TextStyle(color: textColor),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Text(
                                'Text Preview',
                                style: TextStyle(
                                  fontSize: accessibilitySettings.textSize,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),

                              Text(
                                'This is how text will appear on the website.',
                                style: TextStyle(
                                  fontSize: accessibilitySettings.textSize,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // HIGH CONTRAST
                      Card(
                        color: cardColor,
                        child: SwitchListTile(
                          contentPadding: const EdgeInsets.all(15),
                          title: Text(
                            'High Contrast',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          subtitle: Text(
                            'Use stronger colours to make text easier to see.',
                            style: TextStyle(color: textColor),
                          ),
                          value: accessibilitySettings.highContrast,
                          activeThumbColor: const Color(0xFF008C95),
                          onChanged: (value) {
                            accessibilitySettings.updateHighContrast(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // LANGUAGE
                      Card(
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                'Choose your preferred language.',
                                style: TextStyle(color: textColor),
                              ),

                              const SizedBox(height: 15),

                              DropdownButtonFormField<String>(
                                value: accessibilitySettings.selectedLanguage,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'English',
                                    child: Text('English'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Kiswahili',
                                    child: Text('Kiswahili'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    accessibilitySettings.updateLanguage(value);
                                  }
                                },
                              ),

                              const SizedBox(height: 15),

                              Text(
                                accessibilitySettings.selectedLanguage ==
                                        'English'
                                    ? 'Your selected language is English.'
                                    : 'Lugha uliyochagua ni Kiswahili.',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // OTHER ACCESSIBILITY FEATURES
                      Card(
                        color: cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Other Accessibility Features',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),

                              const SizedBox(height: 15),

                              accessibilityItem(
                                Icons.keyboard,
                                'Keyboard Navigation',
                                'Navigate the website using a keyboard.',
                              ),

                              accessibilityItem(
                                Icons.record_voice_over,
                                'Screen Reader Support',
                                'Use descriptive labels for assistive technology.',
                              ),

                              accessibilityItem(
                                Icons.touch_app,
                                'Easy-to-use Buttons',
                                'Buttons are designed to be clear and easy to select.',
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // RETURN TO WEBSITE
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF008C95),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Return to Website',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget accessibilityItem(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF008C95),
            size: 30,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
