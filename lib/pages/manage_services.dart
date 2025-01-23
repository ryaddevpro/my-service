import 'package:flutter/material.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/pages/addservice.dart'; // Page pour ajouter/modifier un service

class ManageServicesPage extends StatefulWidget {
  const ManageServicesPage({super.key});

  @override
  State<ManageServicesPage> createState() => _ManageServicesPageState();
}

class _ManageServicesPageState extends State<ManageServicesPage> {
  final ServiceDAO _serviceDAO = ServiceDAO();
  late Future<List<Service>> servicesFuture;

  @override
  void initState() {
    super.initState();
    servicesFuture = _serviceDAO.getAllServices(); // Charger les services au démarrage
  }

  // Méthode pour supprimer un service
  Future<void> _deleteService(String serviceId) async {
    bool isDeleted = await _serviceDAO.deleteServiceById(serviceId);
    if (isDeleted) {
      setState(() {
        servicesFuture = _serviceDAO.getAllServices(); // Rafraîchir après suppression
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service supprimé avec succès!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Échec de la suppression.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gérer Services'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Service>>(
        future: servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun service trouvé.'));
          }

          final services = snapshot.data!;

          return ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.category, color: Colors.blueAccent),
                  title: Text(service.nom ?? 'Nom indisponible'),
                  subtitle: Text(service.description ?? 'Description indisponible'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bouton pour modifier un service
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddServicePage(service: service),
                            ),
                          ).then((_) {
                            setState(() {
                              servicesFuture = _serviceDAO.getAllServices(); // Rafraîchir après modification
                            });
                          });
                        },
                      ),
                      // Bouton pour supprimer un service
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteService(service.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
