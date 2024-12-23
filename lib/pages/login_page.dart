import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Function to call the backend API
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(
        'http://localhost:5000/api/auth/login'); // Replace localhost with your IP if on a physical device
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      // Success: Redirect to Home Page
      Get.snackbar("Success", "Login successful!",
          snackPosition: SnackPosition.BOTTOM);
      Get.offNamed('/home');
    } else {
      // Error: Show an error message
      final message = json.decode(response.body)['message'];
      Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
            TextButton(
              onPressed: () => Get.toNamed('/signup'),
              child: const Text('Don\'t have an account? Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
