import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/pages/services/services_page.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:my_service/utils/image_util.dart'; // Import ImageUtil

class AddServicePage extends StatefulWidget {
  final Service? service; // Optional parameter for editing existing service

  const AddServicePage({super.key, this.service});

  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _serviceNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _availabilityController = TextEditingController();
  final _categoryController = TextEditingController();
  final _prixController = TextEditingController();

  final _serviceDAO = ServiceDAO();

  String? _base64Image;
  File? _imageFile;

  bool _isLoading = false; // Boolean to track loading state

  // Handle image selection and conversion using ImageUtil
  Future<void> _pickAndConvertImage() async {
    final result = await ImageUtil.pickAndConvertImage();
    if (result.isNotEmpty) {
      setState(() {
        _base64Image = result['base64'];
        _imageFile = result['imageFile'];
      });
    }
  }

  // Get the stored user ID
  Future<String?> getUserId() async {
    return await SharedPreferencesHelper.getValue('userId');
  }

  // Add service function
  void _addService() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    String serviceName = _serviceNameController.text;
    String description = _descriptionController.text;
    String category = _categoryController.text;

    Service newService = Service(
      nom: serviceName,
      description: description,
      categorie: category,
      image: _base64Image,
      prix: double.tryParse(_prixController.text),
      cree_par: await getUserId(),
    );

    bool isCreated = await _serviceDAO.createService(newService);

    setState(() {
      _isLoading = false; // Set loading state to false
    });

    if (isCreated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service ajouté avec succès!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ServicesPage();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue.')),
      );
    }
  }

  // Function to convert base64 string to Image
  Widget _base64ToImage(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes,
        height: 200, width: double.infinity, fit: BoxFit.cover);
  }

  // Update service function
  void _updateService() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    String serviceName = _serviceNameController.text;
    String description = _descriptionController.text;
    String category = _categoryController.text;

    Service updatedService = Service(
      id: widget.service?.id, // Use the existing service ID
      nom: serviceName,
      description: description,
      categorie: category,
      image: _base64Image,
      prix: double.tryParse(_prixController.text),
      cree_par: await getUserId(),
    );

    bool isUpdated = await _serviceDAO.updateService(updatedService);

    setState(() {
      _isLoading = false; // Set loading state to false
    });

    if (isUpdated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service mis à jour avec succès!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ServicesPage();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // If a service is passed for editing, populate the form fields
    if (widget.service != null) {
      _serviceNameController.text = widget.service!.nom ?? '';
      _descriptionController.text = widget.service!.description ?? '';
      _availabilityController.text =
          widget.service!.description ?? ''; // Update as necessary
      _categoryController.text = widget.service!.categorie ?? '';
      _prixController.text = widget.service!.prix?.toString() ?? '';
      _base64Image = widget.service!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service == null
            ? 'Ajouter un Service'
            : 'Modifier un Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ajouter ou modifier un service',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _serviceNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du service',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _availabilityController,
                decoration: const InputDecoration(
                  labelText: 'Disponibilité (ex: 9 AM - 5 PM)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _prixController,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: 'Prix',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickAndConvertImage,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text('Choisir une image'),
              ),
              const SizedBox(height: 20),
              if (_imageFile != null)
                Image.file(
                  _imageFile!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else if (_base64Image != null)
                _base64ToImage(_base64Image!)
              else
                const Text('Aucune image sélectionnée'),
              const SizedBox(height: 30),

              // Show loader if _isLoading is true
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed:
                          widget.service == null ? _addService : _updateService,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Text(widget.service == null
                          ? 'Ajouter un Service'
                          : 'Mettre à jour le Service'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
