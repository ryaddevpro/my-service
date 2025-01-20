import 'package:flutter/material.dart';
import 'package:my_service/DAO/utilisateur.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:my_service/utils/snack_msg.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // Controllers to manage text input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();

  // Sample data (initial values)
  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';
  String userId = '';
  Utilisateur? user;

  @override
  void initState() {
    super.initState();
    _getUserId(); // Fetch user info
  }

  // Fetch user ID and data from SharedPreferences
  _getUserId() async {
    final storedUserId = await SharedPreferencesHelper.getValue('userId');
    if (storedUserId != null) {
      UtilisateurDAO userDAO = UtilisateurDAO();
      user = await userDAO.getUserById(storedUserId);

      setState(() {
        userId = storedUserId;
        firstName = user?.nom ?? '';
        phone = user?.telephone ?? '';
        email = user?.email ?? '';

        // Set initial text in controllers
        _firstNameController.text = firstName;
        _lastNameController.text = lastName;
        _phoneController.text = phone;
        _emailController.text = email;
      });
    } else {
      showMessage("User ID is missing", isError: true);
    }
  }

  // Save updated profile
  void _saveProfile() async {
    if (userId.isEmpty) {
      showMessage("User ID is missing", isError: true);
      return;
    }

    // Validate fields (Optional: Add specific validation if required)
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      showMessage("Please enter a valid email address", isError: true);
      return;
    }

    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      showMessage("Please enter a valid phone number", isError: true);
      return;
    }

    // Create the updated Utilisateur object
    final updatedUser = Utilisateur(
      id: userId,
      nom: _firstNameController.text,
      email: _emailController.text,
      telephone: _phoneController.text,
      password: "", // Optional, if updating password
      role: ROLE_ENUM.client,
      login: "",
    );

    // Call the updateUser function from UtilisateurDAO
    bool isUpdated = await UtilisateurDAO().updateUser(userId, updatedUser);

    if (isUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEditableField('Username', _firstNameController),
              const SizedBox(height: 16),
              _buildEditableField(
                  'Phone Number', _phoneController, TextInputType.phone),
              const SizedBox(height: 16),
              _buildEditableField(
                  'Email', _emailController, TextInputType.emailAddress),
              // const SizedBox(height: 16),
              // _buildEditableField('Profession', _professionController),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable method to build editable fields
  Widget _buildEditableField(String label, TextEditingController controller,
      [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
