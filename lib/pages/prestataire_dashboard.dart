import 'package:flutter/material.dart';
import 'package:my_service/pages/avis_page.dart';
import 'package:my_service/pages/disponibilite.dart';
import 'package:my_service/pages/profile.dart';
import 'package:my_service/pages/reservation.dart';
import 'profile.dart';
import 'disponibilite.dart';
import 'reservation.dart';
import 'avis_page.dart';

class PrestataireDashboard extends StatefulWidget {
  const PrestataireDashboard({super.key});

  @override
  State<PrestataireDashboard> createState() => _PrestataireDashboardState();
}

class _PrestataireDashboardState extends State<PrestataireDashboard> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tableau de Bord Prestataire'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue, Prestataire !',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
