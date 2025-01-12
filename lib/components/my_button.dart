import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          fontSize: 18,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
