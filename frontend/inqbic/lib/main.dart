import 'package:flutter/material.dart';
import 'package:inqbic/Presentation/Onboarding/OnboardingScreen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:inqbic/Presentation/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: kIsWeb ? const LoginPage() : const OnboardingScreen(),
    );
  }
}




