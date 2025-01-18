import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextStyle? style;

  const SearchTextField({super.key, 
    required this.controller,
    this.hintText = 'Search here...',
    this.prefixIcon = Icons.search,
    this.keyboardType = TextInputType.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        style: style ?? TextStyle(fontSize: 16),
        obscureText: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(500),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.only(left: 12.0, top: 5, bottom: 5),
        ),
      ),
    );
  }
}
