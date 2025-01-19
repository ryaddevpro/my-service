import 'package:flutter/material.dart';

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _serviceNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _categoryController = TextEditingController();

  void _addService() {
    // Here you can handle the logic for adding the service
    String serviceName = _serviceNameController.text;
    String description = _descriptionController.text;
    String availability = _availabilityController.text;
    String category = _categoryController.text;

    // You can implement the logic to save this data, such as sending it to an API or saving locally

    // Example:
    print("Service Name: $serviceName");
    print("Description: $description");
    print("Availability: $availability");
    print("Category: $category");

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Service Added Successfully!')),
    );
    
    // Optionally, navigate back after adding the service
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajouter un nouveau service',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Service Name TextField
            TextField(
              controller: _serviceNameController,
              decoration: const InputDecoration(
                labelText: 'Nom du service',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Description TextField
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Availability TextField
            TextField(
              controller: _availabilityController,
              decoration: const InputDecoration(
                labelText: 'Disponibilité (ex: 9 AM - 5 PM)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Category TextField
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Catégorie',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            // Add Service Button
            ElevatedButton(
              onPressed: _addService,
              child: const Text('Ajouter un Service'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
