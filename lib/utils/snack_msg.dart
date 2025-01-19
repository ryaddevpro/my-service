import 'package:flutter/material.dart';
import 'package:my_service/main.dart'; // Import main.dart to access the global key

// Global function to show success or error messages
void showMessage(String message, {bool isError = false}) {
  MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    ),
  );
}
