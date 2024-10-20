// views/login.dart

import 'package:flutter/material.dart';
import 'measurement.dart'; // Import MeasurementPage

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Implement the forgot password functionality here
                print("Forgot password button pressed");
              },
              child: const Text("Forgot password?"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String password = _passwordController.text;

                // Validate email and password
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email and Password cannot be empty')),
                  );
                  return; // Exit the function if validation fails
                }

                // Replace with actual user data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeasurementPage(
                      name: "User Name", // Replace with actual user name
                      email: email,
                      role: "Patient", // Replace with actual user role
                    ),
                  ),
                );
                print("Login button pressed");
              },
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Navigate to the registration page
              },
              child: const Text("Registration"),
            ),
          ],
        ),
      ),
    );
  }
}
