import 'package:flutter/material.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/pages/addservice.dart';
import 'package:my_service/pages/avis_page.dart';
import 'package:my_service/pages/base_page.dart';
import 'package:my_service/pages/disponibilite.dart';
import 'package:my_service/pages/profile.dart';
import 'package:my_service/pages/reservation.dart';
import 'package:my_service/pages/services/services_page.dart';
import 'package:my_service/utils/shared_preferences.dart';

class PrestataireDashboard extends StatefulWidget {
  const PrestataireDashboard({super.key});

  @override
  State<PrestataireDashboard> createState() => _PrestataireDashboardState();
}

class _PrestataireDashboardState extends State<PrestataireDashboard> {
  late Future<Utilisateur?> utilisateurFuture;

  @override
  void initState() {
    super.initState();
    utilisateurFuture = SharedPreferencesHelper.getUtilisateur('user');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tableau de board",
      body: FutureBuilder<Utilisateur?>(
        future: utilisateurFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No user data found'));
          }

          final utilisateur = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue, ${utilisateur.nom} !',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildDashboardCard(
                        icon: Icons.person,
                        title: 'Profil',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilPage(),
                            ),
                          );
                        },
                      ),
                      _buildDashboardCard(
                        icon: Icons.calendar_today,
                        title: 'Disponibilités',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DisponibilitePage(),
                            ),
                          );
                        },
                      ),
                      _buildDashboardCard(
                        icon: Icons.receipt,
                        title: 'Réservations',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationPage(),
                            ),
                          );
                        },
                      ),
                      _buildDashboardCard(
                        icon: Icons.star,
                        title: 'Avis',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AvisPage(),
                            ),
                          );
                        },
                      ),
                      // Add the new "Ajouter un Service" card here
                      _buildDashboardCard(
                        icon: Icons.add_circle_outline,
                        title: 'Ajouter un Service',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddServicePage(), // Navigate to Add Service page
                            ),
                          );
                        },
                      ),

                      _buildDashboardCard(
                        icon: Icons.add_business,
                        title: 'Tous nos Services',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServicesPage(), // Navigate to Add Service page
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to build the dashboard card
  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 6,
        shadowColor: Colors.blueAccent.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blueAccent),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
