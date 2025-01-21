import 'package:flutter/material.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/pages/addservice.dart';
import 'package:my_service/pages/login_page.dart';
import 'package:my_service/pages/prestataire_dashboard.dart';
import 'package:my_service/pages/profile.dart';
import 'package:my_service/pages/services/services_page.dart';
import 'package:my_service/utils/shared_preferences.dart';

class BasePage extends StatefulWidget {
  final Widget body;
  final String title;

  const BasePage({super.key, required this.body, required this.title});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late Future<Utilisateur?> utilisateurFuture;

  @override
  void initState() {
    super.initState();
    utilisateurFuture = SharedPreferencesHelper.getUtilisateur('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey[300],
      ),
      drawer: Drawer(
        child: FutureBuilder<Utilisateur?>(
          future: utilisateurFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading user'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No user found'));
            } else {
              final utilisateur = snapshot.data!;
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrestataireDashboard(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_business),
                    title: const Text('Descouvrir nos Services'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServicesPage(),
                          ));
                    },
                  ),
                  if (utilisateur.role != ROLE_ENUM.client)
                    ListTile(
                      leading: Icon(Icons.add),
                      title: const Text('Add new services'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddServicePage(),
                            ));
                      },
                    ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilPage(),
                          ));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false, // This will remove all previous routes
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: widget.body,
    );
  }
}
