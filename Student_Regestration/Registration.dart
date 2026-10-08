import 'package:flutter/material.dart';

void main() {
runApp(const StudentRegistrationApp());
}

class StudentRegistrationApp extends StatelessWidget {
  const StudentRegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage>createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController nameController =
TextEditingController();

  final TextEditingController emailController =
TextEditingController();

  final TextEditingController phoneController =
TextEditingController();

  String? department;
  String? gender;

  bool acceptedTerms = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
super.dispose();
  }

  // Submit form
  void submitForm() {
    // Validate form fields
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate gender
    if (gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your gender.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate Terms & Conditions
    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the Terms & Conditions.',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Successful submission
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Registration Submitted Successfully',
        ),
        backgroundColor: Colors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Registration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // =========================
              // HEADER
              // =========================

              const Center(
                child: Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  'Student Registration Portal',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // STUDENT NAME
              // =========================

TextFormField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
value.trim().isEmpty) {
                    return 'Student name is required';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // =========================
              // EMAIL
              // =========================

TextFormField(
                controller: emailController,

                keyboardType:
                    TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'example@gmail.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
value.trim().isEmpty) {
                    return 'Email is required';
                  }

                  final emailPattern = RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  );

                  if (!emailPattern.hasMatch(
value.trim(),
                  )) {
                    return 'Enter a valid email address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // =========================
              // PHONE NUMBER
              // =========================

TextFormField(
                controller: phoneController,

                keyboardType:
                    TextInputType.phone,

                maxLength: 10,

                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter 10 digit number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),

                validator: (value) {
                  if (value == null ||
value.isEmpty) {
                    return 'Phone number is required';
                  }

                  if (!RegExp(r'^\d{10}$')
.hasMatch(value)) {
                    return 'Phone number must contain exactly 10 digits';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 18),

              // =========================
              // DEPARTMENT
              // =========================

              DropdownButtonFormField<String>(
                initialValue: department,

                decoration: const InputDecoration(
                  labelText: 'Department',
                  prefixIcon:
Icon(Icons.account_balance),
                  border: OutlineInputBorder(),
                ),

                items: const [
DropdownMenuItem(
                    value: 'CSE',
                    child: Text(
                      'Computer Science Engineering',
                    ),
                  ),

DropdownMenuItem(
                    value: 'ECE',
                    child: Text(
                      'Electronics & Communication',
                    ),
                  ),

DropdownMenuItem(
                    value: 'EEE',
                    child: Text(
                      'Electrical & Electronics',
                    ),
                  ),

DropdownMenuItem(
                    value: 'MECH',
                    child: Text(
                      'Mechanical Engineering',
                    ),
                  ),

DropdownMenuItem(
                    value: 'CIVIL',
                    child: Text(
                      'Civil Engineering',
                    ),
                  ),
                ],

                onChanged: (value) {
setState(() {
                    department = value;
                  });
                },

                validator: (value) {
                  if (value == null) {
                    return 'Please select a department';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 22),

              // =========================
              // GENDER
              // =========================

// =========================
// GENDER
// =========================

DropdownButtonFormField<String>(
  initialValue: gender,

  decoration: const InputDecoration(
    labelText: 'Gender',
    prefixIcon: Icon(Icons.person_outline),
    border: OutlineInputBorder(),
  ),

  items: const [
DropdownMenuItem(
      value: 'Male',
      child: Text('Male'),
    ),

DropdownMenuItem(
      value: 'Female',
      child: Text('Female'),
    ),

DropdownMenuItem(
      value: 'Other',
      child: Text('Other'),
    ),
  ],

  onChanged: (value) {
setState(() {
      gender = value;
    });
  },

  validator: (value) {
    if (value == null) {
      return 'Please select your gender';
    }

    return null;
  },
),



              // =========================
              // TERMS & CONDITIONS
              // =========================

CheckboxListTile(
                contentPadding:
                    EdgeInsets.zero,

                controlAffinity:
                    ListTileControlAffinity.leading,

                title: const Text(
                  'I accept the Terms & Conditions',
                ),

                value: acceptedTerms,

                onChanged: (value) {
setState(() {
                    acceptedTerms =
                        value ?? false;
                  });
                },
              ),

              const SizedBox(height: 20),

              // =========================
              // SUBMIT BUTTON
              // =========================

SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: submitForm,

                  icon: const Icon(Icons.check),

                  label: const Text(
                    'Submit Registration',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
