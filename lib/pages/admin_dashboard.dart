import 'package:flutter/material.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/pages/manage_users.dart';
import 'package:my_service/pages/manage_services.dart';
import 'package:my_service/pages/view_stats.dart';
import 'package:my_service/pages/settings.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:my_service/pages/base_page.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late Future<Utilisateur?> utilisateurFuture;

  @override
  void initState() {
    super.initState();
    utilisateurFuture = SharedPreferencesHelper.getUtilisateur('user');
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Tableau de bord Admin",
      body: FutureBuilder<Utilisateur?>(
        future: utilisateurFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement des données'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Aucune donnée utilisateur trouvée'));
          }

          final utilisateur = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue, Administrateur ${utilisateur.nom} !',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: _getDashboardCards(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _getDashboardCards() {
    return [
      _dashboardCard(Icons.person, 'Gérer Utilisateurs',
              () => _navigateTo(context, const ManageUsersPage())),
      _dashboardCard(Icons.category, 'Gérer Services',
              () => _navigateTo(context, const ManageServicesPage())),
      // _dashboardCard(Icons.analytics, 'Voir Statistiques',
      //         () => _navigateTo(context, const ViewStatsPage())),
      // _dashboardCard(Icons.settings, 'Paramètres',
      //         () => _navigateTo(context, const SettingsPage())),
    ];
  }

  Widget _dashboardCard(IconData icon, String title, VoidCallback onTap) {
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

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
