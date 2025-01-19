import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding and decoding
import 'package:my_service/models/utilisateur.dart'; // Ensure this import is correct

class SharedPreferencesHelper {
  // Method to get a SharedPreferences instance
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  // Store any value in SharedPreferences with a given key
  static Future<void> storeValue(String key, dynamic value) async {
    final prefs = await _getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else if (value is Utilisateur) {
      // Convert Utilisateur object to JSON string
      String jsonString = jsonEncode(value.toJson());
      await prefs.setString(key, jsonString);
    } else {
      throw Exception('Invalid data type');
    }
  }

  // Retrieve any value from SharedPreferences with a given key
  static Future<dynamic> getValue(String key) async {
    final prefs = await _getInstance();
    return prefs.get(key);
  }

  // Retrieve Utilisateur object from SharedPreferences
  static Future<Utilisateur?> getUtilisateur(String key) async {
    final prefs = await _getInstance();
    String? jsonString = prefs.getString(key);

    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return Utilisateur.fromJson(jsonMap);
    }
    return null; // Return null if no Utilisateur found
  }

  // Remove a value from SharedPreferences using a given key
  static Future<void> removeValue(String key) async {
    final prefs = await _getInstance();
    await prefs.remove(key);
  }
}
