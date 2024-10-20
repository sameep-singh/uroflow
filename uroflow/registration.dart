// views/registration.dart

import 'package:flutter/material.dart';
import 'measurement.dart'; // Import MeasurementPage

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _role = 'Patient'; // Initial role value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            DropdownButtonFormField<String>(
              value: _role,
              items: ['Patient', 'Doctor', 'Hospital']
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _role = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Role"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isEmpty || 
                    _emailController.text.isEmpty || 
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required')),
                  );
                  return; // Exit if fields are empty
                }

                // Navigate to the measurement page with user data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeasurementPage(
                      name: _nameController.text,
                      email: _emailController.text,
                      role: _role,
                    ),
                  ),
                );
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
