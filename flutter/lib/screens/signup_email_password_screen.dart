import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';

import '../utils/clip_path_bg.dart';
import 'icons.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController(); // Add second password field controller

  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String _selectedGender = '';
  void signUpUser() async {
    // Check if passwords match before signing up
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Passwords do not match.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (contactController.text.length != 10 ||
        contactController.text[0] != '9') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Contact number must start with 9 and be 10 digits long.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      context.read<FirebaseAuthMethods>().signUpWithEmail(
            email: emailController.text,
            password: passwordController.text,
            gender: genderController.text,
            username: nameController.text,
            contact: contactController.text,
            address: addressController.text,
            context: context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          const ClipPathBackground(
            height: 700,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Welcome to Lanuza Preparedness and Disaster Risk Reduction APP",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 30,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Signup",
                    style: TextStyle(
                      fontSize: isSmallScreen ? 20 : 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: Customicons(
                      controller: nameController,
                      hintText: 'Full Name',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      items: <String>['Male', 'Female']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          genderController.text = value!;
                        });
                      },
                      value: genderController.text.isEmpty
                          ? null
                          : genderController.text,
                      hint: Text("Select Gender"),
                      validator: (value) =>
                          value == null ? 'Please select your gender' : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: Customicons(
                      controller: contactController,
                      hintText: 'Contact Number',
                      icon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: Customicons(
                      controller: addressController,
                      hintText: 'Address',
                      icon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: Customicons(
                      controller: emailController,
                      hintText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: isSmallScreen ? screenWidth : 400,
                    child: Customicons(
                      controller: passwordController,
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: 400,
                      child: Customicons(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icon(Icons.lock),
                        obscureText: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signUpUser,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white),
                      ),
                      fixedSize: MaterialStateProperty.all(
                        const Size(330, 50),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, EmailPasswordLogin.routeName);
                        },
                        child: const Text(
                          "Have an account? Login",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
