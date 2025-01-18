import 'package:flutter/material.dart';
import 'package:my_service/pages/register_page.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 100.0, right: 100.0, bottom: 80.0),
            child: Image.asset('lib/images/service_logo.png'),
          ),

          //another text
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "We bring Services to your doorstep with a single click",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              ),
          ),

          //Text 2
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Anytime, Anywhere",
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          //button
          GestureDetector(
            onTap:() => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return RegisterPage();
              }
            )),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24.0),
              child: const Text("Get Started", style: TextStyle(color: Colors.white),),
            ),
          ),

          const Spacer(),

          
          
        ],
      ),
    );
  }
}