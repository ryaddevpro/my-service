import 'package:flutter/material.dart';
import 'package:my_service/components/my_button.dart';
import 'package:my_service/components/my_textfield.dart';
import 'package:my_service/pages/register_page.dart';
import 'package:flutter/gestures.dart'; // Make sure to import gestures package

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void LoginInUser() {}

  void redirectToRegister(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                _buildLogo(),
                const SizedBox(height: 15),
                _buildWelcomeText(),
                const SizedBox(height: 25),
                _buildTextField(usernameController, 'Username', false),
                const SizedBox(height: 25),
                _buildTextField(passwordController, 'Password', true),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: MyButton(
                    onTap: LoginInUser,
                    text: "Login",
                  ),
                ),
                const SizedBox(height: 15),
                _buildForgotPassword(),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: MyButton(
                    textColor: Colors.black,
                    backgroundColor: const Color.fromARGB(255, 201, 201, 201),
                    onTap: () => redirectToRegister(context),
                    text: "Create Account",
                  ),
                ),
                // const SizedBox(height: 25),
                // _buildContinueWithDivider(),
                // const SizedBox(height: 10),
                // _buildSocialLoginButtons(),
                const SizedBox(height: 25),
                _buildPrivacyText(context),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildLogo() {
  return Icon(
    Icons.lock,
    size: 75,
  );
}

Widget _buildWelcomeText() {
  return Text(
    "Login to My Service",
    style: TextStyle(
      color: Colors.grey[700],
      fontSize: 24,
    ),
  );
}

Widget _buildTextField(
    TextEditingController controller, String hintText, bool obscureText) {
  return MyTextfield(
    controller: controller,
    hintText: hintText,
    obscureText: obscureText,
  );
}

Widget _buildForgotPassword() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot password!',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  );
}

Widget _buildContinueWithDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Or continue with",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSocialLoginButtons() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => {},
            style: ElevatedButton.styleFrom(
              padding:
                  EdgeInsets.all(16), // Optional: adjust the button padding
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  children: [
                    Image.network("https://i.imgur.com/uHm3CLH.png"),
                  ],
                ),
                Positioned(
                  child: Text(
                    "Google",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Optional: make text bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPrivacyText(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
                color: Colors.grey[700]), // Default style for the text

            children: [
              TextSpan(
                text: "By clicking continue, you agree to our ",
              ),
              TextSpan(
                text: "Terms of Service",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
              ),
              TextSpan(
                text: " and ",
              ),
              TextSpan(
                text: "Privacy Policy",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
