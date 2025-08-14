import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:inqbic/Model/UserModel.dart';
import 'package:inqbic/Presentation/login.dart';
import 'package:inqbic/api/createUser.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController fristNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  bool _obscureText = true;
  String genderChoice = '';

  String ? error;
  String ? key ;

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
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                    height: MediaQuery.of(context).size.height * 0.95,
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
                            'Hey, Register Now :)',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.height * 0.2,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Username
                        const Text('Username', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorText: key == 'username' ? error : null,
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // First & Last Name
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('First Name'),
                                  const SizedBox(height: 5),
                                  TextField(
                                    controller: fristNameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green, width: 2),
                                      ),
                                      labelText: 'First name',
                                      hintText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Last Name'),
                                  const SizedBox(height: 5),
                                  TextField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green, width: 2),
                                      ),
                                      labelText: 'Last name',
                                      hintText: 'Last Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        const Text('Age', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Age',
                            hintText: 'Enter age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),

                        const SizedBox(height: 10),
                        const Text('Gender', textAlign: TextAlign.left),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Radio<String>(
                              value: "Male",
                              groupValue: genderChoice,
                              onChanged: (value) {
                                setState(() { genderChoice = value!; });
                              },
                            ),
                            const Text("Male"),
                            Radio<String>(
                              value: "Female",
                              groupValue: genderChoice,
                              onChanged: (value) {
                                setState(() { genderChoice = value!; });
                              },
                            ),
                            const Text("Female"),
                            Radio<String>(
                              value: "Others",
                              groupValue: genderChoice,
                              onChanged: (value) {
                                setState(() { genderChoice = value!; });
                              },
                            ),
                            const Text("Others"),
                          ],
                        ),

                        const SizedBox(height: 10),
                        const Text('Email', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter your mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorText: key == 'email' ? error : null,
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),

                        const SizedBox(height: 10),
                        const Text('Password', textAlign: TextAlign.left),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: _obscureText,
                          obscuringCharacter: '-',
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green, width: 2),
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                setState(() { _obscureText = !_obscureText; });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () async {
                            UserData userData = UserData(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            ProfileData profileData = ProfileData(
                              fname: fristNameController.text,
                              lname: lastNameController.text,
                              gender: genderChoice,
                              age: int.parse(ageController.text),
                            );
                            UserModel userModel =
                            UserModel(userData: userData, profileData: profileData);

                            final response = await createUser(userModel);
                            if (response.statusCode == 201) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            } else {
                              final res_body = jsonDecode(response.body);
                              setState(() {
                                error = res_body['message'] ?? "Something went wrong";
                                key = res_body['key'] ?? '';
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
                            'Register',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: (MediaQuery.of(context).size.width) * 0.38, height: 2, color: Colors.green),
                            const SizedBox(width: 8),
                            const Text('or'),
                            const SizedBox(width: 8),
                            Container(width: (MediaQuery.of(context).size.width) * 0.38, height: 2, color: Colors.green),
                          ],
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=> LoginPage() )
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
                            'Login',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black
                            ),
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
            width: MediaQuery.of(context).size.width * 0.45, // narrower form for web
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
                    'Hey, Register Now :)',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 3,
                  width: 150,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),

                // Username
                const Text('Username'),
                const SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: key == 'username' ? error : null,
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 15),

                // First & Last Name in Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('First Name'),
                          const SizedBox(height: 5),
                          TextField(
                            controller: fristNameController,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green, width: 2),
                              ),
                              labelText: 'First name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Last Name'),
                          const SizedBox(height: 5),
                          TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green, width: 2),
                              ),
                              labelText: 'Last name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),
                const Text('Age'),
                const SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    labelText: 'Age',
                    hintText: 'Enter age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                ),

                const SizedBox(height: 15),
                const Text('Gender'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: genderChoice,
                      onChanged: (value) {
                        setState(() {
                          genderChoice = value!;
                        });
                      },
                    ),
                    const Text("Male"),
                    Radio<String>(
                      value: "Female",
                      groupValue: genderChoice,
                      onChanged: (value) {
                        setState(() {
                          genderChoice = value!;
                        });
                      },
                    ),
                    const Text("Female"),
                    Radio<String>(
                      value: "Others",
                      groupValue: genderChoice,
                      onChanged: (value) {
                        setState(() {
                          genderChoice = value!;
                        });
                      },
                    ),
                    const Text("Others"),
                  ],
                ),

                const SizedBox(height: 15),
                const Text('Email'),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: key == 'email' ? error : null,
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 15),
                const Text('Password'),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  obscuringCharacter: '-',
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
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
                    UserData userData = UserData(
                      username: usernameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    ProfileData profileData = ProfileData(
                      fname: fristNameController.text,
                      lname: lastNameController.text,
                      gender: genderChoice,
                      age: int.parse(ageController.text),
                    );
                    UserModel userModel =
                    UserModel(userData: userData, profileData: profileData);

                    final response = await createUser(userModel);
                    if (response.statusCode == 201) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    } else {
                      final res_body = jsonDecode(response.body);
                      setState(() {
                        error = res_body['message'] ?? "Something went wrong";
                        key = res_body['key'] ?? '';
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
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 100, height: 2, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text('or'),
                    const SizedBox(width: 8),
                    Container(width: 100, height: 2, color: Colors.green),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
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
                    'Login',
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
