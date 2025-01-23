import 'package:flutter/material.dart';
import 'package:my_service/DAO/utilisateur.dart';
import 'package:my_service/models/utilisateur.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  final UtilisateurDAO _utilisateurDAO = UtilisateurDAO();
  late Future<List<Utilisateur>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = _utilisateurDAO.getAllUsers(); // Utilisation de getAllUsers
  }

  // Méthode pour supprimer un utilisateur
  Future<void> _deleteUser(String email) async {
    bool isDeleted = await _utilisateurDAO.deleteUser(email);
    if (isDeleted) {
      setState(() {
        usersFuture = _utilisateurDAO.getAllUsers(); // Rafraîchir la liste après suppression
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Utilisateur supprimé avec succès!')),
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
        title: const Text('Gérer Utilisateurs'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Utilisateur>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun utilisateur trouvé.'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.blueAccent),
                  title: Text(user.nom ?? 'Nom indisponible'),
                  subtitle: Text(user.email ?? 'Email indisponible'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(user.email!), // Suppression par email
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
