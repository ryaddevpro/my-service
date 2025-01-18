import 'package:flutter/material.dart';
import 'package:my_service/components/my_textfield.dart';
import 'package:my_service/components/my_button.dart';
import 'package:my_service/pages/dashboard_page.dart';
import 'package:my_service/pages/register_page.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Login method
  void loginUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  // Redirect to Register Page
  void redirectToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

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
                const SizedBox(height: 40),
                _buildLogo(),
                const SizedBox(height: 20),
                _buildWelcomeText(),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  child: MyTextfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, right: 24.0, left: 24.0),
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
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
                        "Create Account",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),



                const SizedBox(height: 16),
                _buildPrivacyText(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const Icon(
      Icons.lock,
      size: 75,
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      "Login to My Service",
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPrivacyText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
    );
  }
}
