import 'package:flutter/material.dart';

import 'package:my_service/components/my_textfield.dart';
import 'package:my_service/pages/login_page.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // Controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedRole; // Variable to hold the selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                const Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                  child: Text(
                    "Register to My Service",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Username Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                ),

                // Email Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                ),

                // Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ),

                // Confirm Password Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: confirmPasswordController,
                    hintText: 'Confirm password',
                    obscureText: true,
                  ),
                ),

                // Role Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: InputDecoration(
                      hintText: 'Select Role',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: "client", child: Text("Client")),
                      DropdownMenuItem(value: "vendeur", child: Text("Vendeur")),
                    ],
                    onChanged: (value) {
                      selectedRole = value;
                    },
                  ),
                ),

                

                // Register Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                // Privacy Text
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        "By clicking continue, you agree to our ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Terms of Service",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(" and "),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
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
    );
  }
}