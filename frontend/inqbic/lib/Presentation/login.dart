import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:inqbic/Model/UserModel.dart';
import 'package:inqbic/Presentation/home.dart';
import 'package:inqbic/Presentation/signup.dart';
import 'package:inqbic/api/authUser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? error;
  bool _obscureText = true;

  // Move controllers to state
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? _buildWebUI(context) : _buildMobileUI(context);
  }

  Widget _buildMobileUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Center(
                          child: Text(
                            'Welcome Back !!!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text('Email', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailTextController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter your mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.email),
                            errorText: error,
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Text('Password', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          obscuringCharacter: '-',
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            AuthData authdata = AuthData(
                              email: emailTextController.text,
                              password: passwordController.text,
                            );

                            final response = await authUser(authdata);

                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              // Navigate to authenticated page
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const AuthenticatedPage()),
                              );
                            } else {
                              final res_body = jsonDecode(response.body);
                              setState(() {
                                error = res_body['message']?.toString();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width:
                                MediaQuery.of(context).size.width * 0.38,
                                height: 2,
                                color: Colors.green),
                            const SizedBox(width: 8),
                            const Text('or'),
                            const SizedBox(width: 8),
                            Container(
                                width:
                                MediaQuery.of(context).size.width * 0.38,
                                height: 2,
                                color: Colors.green),
                          ],
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWebUI(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width * 0.4, // narrower for web
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Welcome Back !!!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: MediaQuery.of(context).size.height * 0.2,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),

                const Text('Email'),
                const SizedBox(height: 10),
                TextField(
                  controller: emailTextController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green, width: 2),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    errorText: error,
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Password'),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  obscuringCharacter: '-',
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green, width: 2),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    AuthData authdata = AuthData(
                      email: emailTextController.text,
                      password: passwordController.text,
                    );

                    final response = await authUser(authdata);

                    if (response.statusCode == 200 || response.statusCode == 201) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const AuthenticatedPage()),
                      );
                    } else {
                      final res_body = jsonDecode(response.body);
                      setState(() {
                        error = res_body['message']?.toString();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 100, height: 2, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text('or'),
                    const SizedBox(width: 8),
                    Container(
                        width: 100, height: 2, color: Colors.green),
                  ],
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SignUp',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
