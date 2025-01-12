import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return // username text field
        Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(hintText),
            ],
          ),
          TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(8), // Added this
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
