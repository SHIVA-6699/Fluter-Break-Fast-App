import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: '/login', // Start at the login page
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()), // Login route
        GetPage(name: '/signup', page: () => SignupPage()), // Signup route
        GetPage(name: '/home', page: () => HomePage()), // Home route
      ],
    );
  }
}
