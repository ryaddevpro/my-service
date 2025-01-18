import 'package:flutter/material.dart';

class PrestataireDashboard extends StatelessWidget {
  const PrestataireDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Prestataire'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue, Prestataire !',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Nombre de colonnes
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildDashboardCard(
                    icon: Icons.person,
                    title: 'Profil',
                    onTap: () {
                      Navigator.pushNamed(context, '/profil');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.calendar_today,
                    title: 'Disponibilités',
                    onTap: () {
                      Navigator.pushNamed(context, '/disponibilites');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.receipt,
                    title: 'Réservations',
                    onTap: () {
                      Navigator.pushNamed(context, '/reservations');
                    },
                  ),
                  _buildDashboardCard(
                    icon: Icons.star,
                    title: 'Avis',
                    onTap: () {
                      Navigator.pushNamed(context, '/avis');
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
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
