
import 'package:flutter/material.dart';
import 'accessibility_settings.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int currentStep = 0;

  String? selectedDepartment;
  String? selectedDoctor;
  DateTime? selectedDate;
  String? selectedTime;

  bool bookingComplete = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final Color primaryColor = const Color(0xFF008C95);

  bool get highContrast => accessibilitySettings.highContrast;

  bool get isSwahili =>
      accessibilitySettings.selectedLanguage == 'Kiswahili';

  Color get backgroundColor =>
      highContrast ? Colors.black : Colors.white;

  Color get textColor =>
      highContrast ? Colors.white : Colors.black87;

  Color get cardColor =>
      highContrast ? const Color(0xFF222222) : Colors.white;

  Color get selectedColor =>
      highContrast ? const Color(0xFF333300) : const Color(0xFFE0F5F5);

  Color get accentColor =>
      highContrast ? Colors.yellow : primaryColor;

  Color get buttonTextColor =>
      highContrast ? Colors.black : Colors.white;

  String tr(String english) {
    if (!isSwahili) return english;

    const translations = {
      'CareConnect': 'CareConnect',
      'Book an Appointment': 'Weka Miadi',
      'Follow the steps below to book your hospital appointment.':
          'Fuata hatua zilizo hapa chini kuweka miadi yako ya hospitali.',
      'Department': 'Idara',
      'Doctor': 'Daktari',
      'Date': 'Tarehe',
      'Time': 'Muda',
      'Confirm': 'Thibitisha',
      'Back': 'Rudi',
      'Next': 'Endelea',
      'Confirm Appointment': 'Thibitisha Miadi',
      'What type of care do you need?':
          'Unahitaji huduma gani ya afya?',
      'Choose a hospital department.':
          'Chagua idara ya hospitali.',
      'Heart and cardiovascular care':
          'Huduma za moyo na mishipa ya damu',
      'Dental and oral healthcare':
          'Huduma za meno na kinywa',
      'Eye examinations and treatment':
          'Uchunguzi na matibabu ya macho',
      'Healthcare for children':
          'Huduma za afya kwa watoto',
      'Choose Your Doctor': 'Chagua Daktari Wako',
      'Available doctors in': 'Madaktari wanaopatikana katika',
      'Choose Appointment Date': 'Chagua Tarehe ya Miadi',
      'Select one of the dates below.':
          'Chagua moja ya tarehe zilizo hapa chini.',
      'Available (sample slot)': 'Inapatikana (nafasi ya mfano)',
      'Choose Appointment Time': 'Chagua Muda wa Miadi',
      'Choose your preferred time.':
          'Chagua muda unaopendelea.',
      'Fully booked': 'Nafasi zimejaa',
      'Available': 'Inapatikana',
      'Review Your Appointment': 'Kagua Miadi Yako',
      'Patient Information': 'Taarifa za Mgonjwa',
      'Full Name': 'Jina Kamili',
      'Email Address': 'Anwani ya Barua Pepe',
      'Phone Number': 'Nambari ya Simu',
      'Please enter your full name.':
          'Tafadhali ingiza jina lako kamili.',
      'Please enter a valid email address.':
          'Tafadhali ingiza anwani sahihi ya barua pepe.',
      'Please enter a valid phone number.':
          'Tafadhali ingiza nambari sahihi ya simu.',
      'Please select a department.':
          'Tafadhali chagua idara.',
      'Please select a doctor.':
          'Tafadhali chagua daktari.',
      'Please select an appointment date.':
          'Tafadhali chagua tarehe ya miadi.',
      'Please select an appointment time.':
          'Tafadhali chagua muda wa miadi.',
      'Appointment Confirmed!': 'Miadi Imethibitishwa!',
      'Your appointment request has been completed successfully.':
          'Ombi lako la miadi limekamilika kikamilifu.',
      'Patient': 'Mgonjwa',
      'Return to Home': 'Rudi Mwanzo',
    };

    return translations[english] ?? english;
  }

  final Map<String, List<String>> doctors = {
    'Cardiology': [
      'Dr. Jane Mwangi',
      'Dr. Peter Kamau',
    ],
    'Dental': [
      'Dr. Mary Wanjiku',
      'Dr. Brian Otieno',
    ],
    'Eye Clinic': [
      'Dr. Sarah Njeri',
      'Dr. David Kimani',
    ],
    'Pediatrics': [
      'Dr. Grace Achieng',
      'Dr. James Mutua',
    ],
  };

  final List<String> appointmentTimes = [
    '9:00 AM',
    '10:30 AM',
    '2:00 PM',
    '3:30 PM',
  ];

  List<DateTime> get availableDates {
    return List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index + 1)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];

    const swahiliMonths = [
      'Januari', 'Februari', 'Machi', 'Aprili',
      'Mei', 'Juni', 'Julai', 'Agosti',
      'Septemba', 'Oktoba', 'Novemba', 'Desemba'
    ];

    const days = [
      'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];

    const swahiliDays = [
      'Jumatatu', 'Jumanne', 'Jumatano',
      'Alhamisi', 'Ijumaa', 'Jumamosi', 'Jumapili'
    ];

    final day = isSwahili
        ? swahiliDays[date.weekday - 1]
        : days[date.weekday - 1];

    final month = isSwahili
        ? swahiliMonths[date.month - 1]
        : months[date.month - 1];

    return '$day, ${date.day} $month ${date.year}';
  }

  void nextStep() {
    if (currentStep == 0 && selectedDepartment == null) {
      showMessage(tr('Please select a department.'));
      return;
    }

    if (currentStep == 1 && selectedDoctor == null) {
      showMessage(tr('Please select a doctor.'));
      return;
    }

    if (currentStep == 2 && selectedDate == null) {
      showMessage(tr('Please select an appointment date.'));
      return;
    }

    if (currentStep == 3 && selectedTime == null) {
      showMessage(tr('Please select an appointment time.'));
      return;
    }

    if (currentStep == 4) {
      if (!formKey.currentState!.validate()) return;

      setState(() {
        bookingComplete = true;
      });
      return;
    }

    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessibilitySettings,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            brightness: highContrast ? Brightness.dark : Brightness.light,
            scaffoldBackgroundColor: backgroundColor,
            colorScheme: highContrast
                ? const ColorScheme.dark(
                    primary: Colors.yellow,
                    onPrimary: Colors.black,
                    surface: Color(0xFF222222),
                    onSurface: Colors.white,
                  )
                : ColorScheme.fromSeed(seedColor: primaryColor),
          ),
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: Text(
                tr('CareConnect'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: highContrast ? Colors.black : primaryColor,
              foregroundColor: highContrast ? Colors.yellow : Colors.white,
            ),
            body: DefaultTextStyle(
              style: TextStyle(color: textColor),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 750),
                    child: bookingComplete
                        ? buildSuccessPage()
                        : buildBookingPage(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBookingPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('Book an Appointment'),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          tr('Follow the steps below to book your hospital appointment.'),
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        const SizedBox(height: 30),
        buildProgress(),
        const SizedBox(height: 35),

        if (currentStep == 0) buildDepartmentStep(),
        if (currentStep == 1) buildDoctorStep(),
        if (currentStep == 2) buildDateStep(),
        if (currentStep == 3) buildTimeStep(),
        if (currentStep == 4) buildConfirmationStep(),

        const SizedBox(height: 35),

        Row(
          children: [
            if (currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: previousStep,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor),
                    padding: const EdgeInsets.all(18),
                  ),
                  child: Text(tr('Back')),
                ),
              ),
            if (currentStep > 0) const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                onPressed: nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: buttonTextColor,
                  padding: const EdgeInsets.all(18),
                ),
                child: Text(
                  currentStep == 4
                      ? tr('Confirm Appointment')
                      : tr('Next'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProgress() {
    final steps = [
      'Department',
      'Doctor',
      'Date',
      'Time',
      'Confirm',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${tr('Step')} ${currentStep + 1} ${tr('of')} 5: ${tr(steps[currentStep])}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: (currentStep + 1) / 5,
          minHeight: 9,
          backgroundColor: highContrast ? Colors.grey.shade800 : Colors.grey.shade300,
          color: accentColor,
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            steps.length,
            (index) => Chip(
              label: Text(tr(steps[index])),
              backgroundColor: index == currentStep
                  ? accentColor
                  : cardColor,
              side: BorderSide(
                color: highContrast ? Colors.white : Colors.grey.shade400,
              ),
              labelStyle: TextStyle(
                color: index == currentStep ? buttonTextColor : textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDepartmentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('What type of care do you need?'),
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(tr('Choose a hospital department.')),
        const SizedBox(height: 25),
        departmentCard(
          'Cardiology',
          'Heart and cardiovascular care',
          Icons.favorite,
        ),
        departmentCard(
          'Dental',
          'Dental and oral healthcare',
          Icons.medical_services,
        ),
        departmentCard(
          'Eye Clinic',
          'Eye examinations and treatment',
          Icons.remove_red_eye,
        ),
        departmentCard(
          'Pediatrics',
          'Healthcare for children',
          Icons.child_care,
        ),
      ],
    );
  }

  Widget departmentCard(
    String name,
    String description,
    IconData icon,
  ) {
    bool isSelected = selectedDepartment == name;

    return Card(
      elevation: 0,
      color: isSelected ? selectedColor : cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? accentColor : (highContrast ? Colors.white : Colors.grey.shade400),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Icon(icon, color: accentColor, size: 35),
        title: Text(
          tr(name),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: textColor,
          ),
        ),
        subtitle: Text(
          tr(description),
          style: TextStyle(color: textColor),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: accentColor)
            : Icon(Icons.circle_outlined, color: textColor),
        onTap: () {
          setState(() {
            selectedDepartment = name;
            selectedDoctor = null;
          });
        },
      ),
    );
  }

  Widget buildDoctorStep() {
    final departmentDoctors = doctors[selectedDepartment] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('Choose Your Doctor'),
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Text('${tr('Available doctors in')} ${tr(selectedDepartment!)}.'),
        const SizedBox(height: 25),
        ...departmentDoctors.map((doctor) {
          bool isSelected = selectedDoctor == doctor;

          return Card(
            elevation: 0,
            color: isSelected ? selectedColor : cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? accentColor : (highContrast ? Colors.white : Colors.grey.shade400),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor: selectedColor,
                child: Icon(Icons.person, color: accentColor),
              ),
              title: Text(
                doctor,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              subtitle: Text(
                tr(selectedDepartment!),
                style: TextStyle(color: textColor),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: accentColor)
                  : Icon(Icons.circle_outlined, color: textColor),
              onTap: () {
                setState(() {
                  selectedDoctor = doctor;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildDateStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('Choose Appointment Date'),
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(tr('Select one of the dates below.')),
        const SizedBox(height: 25),
        ...availableDates.map((date) {
          bool isSelected = selectedDate != null &&
              selectedDate!.year == date.year &&
              selectedDate!.month == date.month &&
              selectedDate!.day == date.day;

          return Card(
            elevation: 0,
            color: isSelected ? selectedColor : cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? accentColor : (highContrast ? Colors.white : Colors.grey.shade400),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.calendar_month, color: accentColor),
              title: Text(
                formatDate(date),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                tr('Available (sample slot)'),
                style: TextStyle(color: textColor),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: accentColor)
                  : Icon(Icons.circle_outlined, color: textColor),
              onTap: () {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget buildTimeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('Choose Appointment Time'),
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(tr('Choose your preferred time.')),
        const SizedBox(height: 25),
        ...appointmentTimes.map((time) {
          bool isSelected = selectedTime == time;
          bool isBooked = time == '2:00 PM';

          return Card(
            elevation: 0,
            color: isSelected ? selectedColor : cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? accentColor : (highContrast ? Colors.white : Colors.grey.shade400),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.access_time,
                color: isBooked ? Colors.grey : accentColor,
              ),
              title: Text(time, style: TextStyle(color: textColor)),
              subtitle: Text(
                isBooked ? tr('Fully booked') : tr('Available'),
                style: TextStyle(
                  color: isBooked
                      ? (highContrast ? Colors.white70 : Colors.black54)
                      : (highContrast ? Colors.yellow : Colors.green.shade800),
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: accentColor)
                  : Icon(
                      isBooked ? Icons.block : Icons.circle_outlined,
                      color: textColor,
                    ),
              onTap: isBooked
                  ? null
                  : () {
                      setState(() {
                        selectedTime = time;
                      });
                    },
            ),
          );
        }),
      ],
    );
  }

  Widget buildConfirmationStep() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr('Review Your Appointment'),
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: selectedColor,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summaryRow('Department', tr(selectedDepartment!)),
                  summaryRow('Doctor', selectedDoctor!),
                  summaryRow('Date', formatDate(selectedDate!)),
                  summaryRow('Time', selectedTime!),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            tr('Patient Information'),
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            style: TextStyle(color: textColor),
            decoration: inputDecoration('Full Name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return tr('Please enter your full name.');
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: textColor),
            decoration: inputDecoration('Email Address'),
            validator: (value) {
              if (value == null ||
                  !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                      .hasMatch(value.trim())) {
                return tr('Please enter a valid email address.');
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(color: textColor),
            decoration: inputDecoration('Phone Number'),
            validator: (value) {
              if (value == null || value.trim().length < 9) {
                return tr('Please enter a valid phone number.');
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: tr(label),
      labelStyle: TextStyle(color: textColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: highContrast ? Colors.white : Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  Widget summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${tr(label)}:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuccessPage() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Icon(
          Icons.check_circle,
          color: highContrast ? Colors.yellow : Colors.green.shade700,
          size: 90,
        ),
        const SizedBox(height: 20),
        Text(
          tr('Appointment Confirmed!'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: accentColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          tr('Your appointment request has been completed successfully.'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: textColor),
        ),
        const SizedBox(height: 30),
        Card(
          color: selectedColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                summaryRow('Patient', nameController.text),
                summaryRow('Department', tr(selectedDepartment!)),
                summaryRow('Doctor', selectedDoctor!),
                summaryRow('Date', formatDate(selectedDate!)),
                summaryRow('Time', selectedTime!),
                summaryRow('Email Address', emailController.text),
                summaryRow('Phone Number', phoneController.text),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            foregroundColor: buttonTextColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 18,
            ),
          ),
          child: Text(tr('Return to Home')),
        ),
      ],
    );
  }
}
