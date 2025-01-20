  import 'dart:convert';
  import 'dart:io';
  import 'dart:typed_data';
  import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';

  class ImageUtil {
    // Method to pick an image from the gallery and convert it to Base64
    static Future<Map<String, dynamic>> pickAndConvertImage() async {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64Image = base64Encode(bytes);
        final imageFile = File(image.path); // Store the selected image file
        return {'base64': base64Image, 'imageFile': imageFile};
      } else {
        return {}; // Return an empty map if no image is selected
      }
    }

    // Method to convert image file to Base64
    static Future<String?> convertImageToBase64FromFile(File imageFile) async {
      try {
        // Read image as bytes
        final bytes = await imageFile.readAsBytes();
        // Convert bytes to Base64 string
        final base64Image = base64Encode(bytes);
        return base64Image;
      } catch (e) {
        print("Error converting image to Base64: $e");
        return null; // Return null if there's an error
      }
    }

    // Method to decode Base64 string to Uint8List (bytes)
    static Uint8List decodeBase64ToBytes(String base64String) {
      return base64Decode(base64String);
    }
  }
