import 'package:flutter/material.dart';

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
  String firstName = 'John';
  String lastName = 'Doe';
  String phone = '+1234567890';
  String email = 'johndoe@example.com';
  String profession = 'Web Developer';

  @override
  void initState() {
    super.initState();

    // Initializing controllers with the sample data
    _firstNameController.text = firstName;
    _lastNameController.text = lastName;
    _phoneController.text = phone;
    _emailController.text = email;
    _professionController.text = profession;
  }

  void _saveProfile() {
    setState(() {
      // Updating profile with the new values from the controllers
      firstName = _firstNameController.text;
      lastName = _lastNameController.text;
      phone = _phoneController.text;
      email = _emailController.text;
      profession = _professionController.text;
    });

    // You can save to a database or perform additional actions here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!')),
    );
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
              // First Name
              _buildEditableField(
                label: 'First Name',
                controller: _firstNameController,
              ),
              const SizedBox(height: 16),

              // Last Name
              _buildEditableField(
                label: 'Last Name',
                controller: _lastNameController,
              ),
              const SizedBox(height: 16),

              // Phone Number
              _buildEditableField(
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Email
              _buildEditableField(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Profession
              _buildEditableField(
                label: 'Profession',
                controller: _professionController,
              ),
              const SizedBox(height: 32),

              // Save Button
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blueAccent, // Accent color
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
  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
