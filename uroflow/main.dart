import 'package:flutter/material.dart';
import 'views/login.dart'; // Import the LoginPage
import 'views/registration.dart'; // Import the RegistrationPage

void main() {
  runApp(UROFLOWApp());
}

class UROFLOWApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UROFLOW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // Set the login page as the initial route
        '/register': (context) => RegistrationPage(), // Set the registration page route
      },
    );
  }
}
