import 'package:flutter/material.dart';

class AuthenticatedPage extends StatelessWidget {
  const AuthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'You are authenticated user',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
