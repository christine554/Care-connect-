
import 'package:flutter/material.dart';
import 'package:appointment/pages/accessibility.dart';
import 'package:appointment/pages/accessibility_settings.dart';
import 'package:appointment/widgets/service_card.dart';
import 'booking.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessibilitySettings,
      builder: (context, child) {
        final bool highContrast = accessibilitySettings.highContrast;
        final bool isSwahili =
            accessibilitySettings.selectedLanguage == 'Kiswahili';

        final Color backgroundColor =
            highContrast ? Colors.black : Colors.white;

        final Color textColor =
            highContrast ? Colors.white : Colors.black87;

        final Color sectionColor =
            highContrast ? const Color(0xFF222222) : const Color(0xFFE8F6F6);

        final Color secondarySectionColor =
            highContrast ? Colors.black : const Color(0xFFF2F8F8);

        final Color accentColor =
            highContrast ? Colors.yellow : const Color(0xFF008C95);

        final Color buttonBackground =
            highContrast ? Colors.yellow : const Color(0xFF008C95);

        final Color buttonText =
            highContrast ? Colors.black : Colors.white;

        return Scaffold(
          backgroundColor: backgroundColor,

          // APP BAR
          appBar: AppBar(
            backgroundColor: highContrast ? Colors.black : Colors.white,
            foregroundColor: textColor,
            elevation: 1,
            title: Text(
              'CareConnect',
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  isSwahili ? 'Mwanzo' : 'Home',
                  style: TextStyle(color: textColor),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  isSwahili ? 'Huduma' : 'Services',
                  style: TextStyle(color: textColor),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Text(
                  isSwahili ? 'Kuhusu Sisi' : 'About Us',
                  style: TextStyle(color: textColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccessibilityPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.accessibility, color: accentColor),
                  label: Text(
                    isSwahili ? 'Ufikivu' : 'Accessibility',
                    style: TextStyle(color: accentColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: accentColor),
                  ),
                ),
              ),
            ],
          ),

          // BODY
          body: SingleChildScrollView(
            child: Column(
              children: [
                // WELCOME SECTION
                Container(
                  width: double.infinity,
                  color: sectionColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 65,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isSwahili
                                ? 'Afya Yako, Kipaumbele Chetu'
                                : 'Your Health, Our Priority',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            isSwahili
                                ? 'Weka miadi ya hospitali kwa urahisi, haraka na kwa urahisi kutoka mahali popote.'
                                : 'Book your hospital appointments easily, quickly and conveniently from anywhere.',
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                            ),
                          ),

                          const SizedBox(height: 30),

                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BookingPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.calendar_month),
                            label: Text(
                              isSwahili ? 'Weka Miadi' : 'Book Appointment',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonBackground,
                              foregroundColor: buttonText,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            isSwahili
                                ? 'Rahisi • Inafaa • Inapatikana kwa Wote'
                                : 'Simple • Convenient • Accessible',
                            style: TextStyle(
                              fontSize: 15,
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                // SERVICES SECTION
                Text(
                  isSwahili ? 'Huduma Zetu' : 'Our Services',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  isSwahili
                      ? 'Gundua huduma zetu za afya'
                      : 'Explore our healthcare services',
                  style: TextStyle(
                    fontSize: 16,
                    color: highContrast ? Colors.white70 : Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      ServiceCard(
                        icon: Icons.local_hospital,
                        title: isSwahili ? 'Dawa ya Jumla' : 'General Medicine',
                        description: isSwahili
                            ? 'Wasiliana na madaktari kwa huduma za afya kwa ujumla.'
                            : 'Consult doctors for general health services.',
                      ),

                      ServiceCard(
                        icon: Icons.child_care,
                        title: isSwahili ? 'Huduma za Uzazi' : 'Maternity Care',
                        description: isSwahili
                            ? 'Huduma za afya kwa akina mama na watoto.'
                            : 'Healthcare services for mothers and babies.',
                      ),

                      ServiceCard(
                        icon: Icons.medical_services,
                        title: isSwahili ? 'Huduma za Meno' : 'Dental Care',
                        description: isSwahili
                            ? 'Pata huduma bora za afya ya meno.'
                            : 'Get professional dental healthcare services.',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // ACCESSIBILITY INFORMATION
                Container(
                  width: double.infinity,
                  color: secondarySectionColor,
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    children: [
                      Icon(
                        Icons.accessibility_new,
                        size: 45,
                        color: accentColor,
                      ),

                      const SizedBox(height: 15),

                      Text(
                        isSwahili
                            ? 'Huduma za Afya kwa Kila Mtu'
                            : 'Healthcare for Everyone',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        isSwahili
                            ? 'Mfumo wetu unalenga kufanya miadi ya hospitali iwe rahisi na inayopatikana kwa kila mtu, pamoja na watu wenye ulemavu.'
                            : 'Our platform aims to make hospital appointments simple and accessible to everyone, including people with disabilities.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // FOOTER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  color: highContrast
                      ? const Color(0xFF222222)
                      : const Color(0xFF006D75),
                  child: Text(
                    isSwahili
                        ? '© 2026 CareConnect. Haki Zote Zimehifadhiwa.'
                        : '© 2026 CareConnect. All Rights Reserved.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: highContrast ? Colors.yellow : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
