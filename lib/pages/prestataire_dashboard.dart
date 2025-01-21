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
      title: "Tableau de bord",
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
                  'Bienvenue : ${utilisateur.role?.name} ${utilisateur.nom} !',
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
                    children: _getDashboardCards(utilisateur.role),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _getDashboardCards(ROLE_ENUM? role) {
    final clientCards = [
      _dashboardCard(Icons.person, 'Profil',
          () => _navigateTo(context, const ProfilPage())),
      _dashboardCard(Icons.receipt, 'Réservations',
          () => _navigateTo(context, ReservationPage())),
      // _dashboardCard(
      //     Icons.star, 'Avis', () => _navigateTo(context, AvisPage())),
      _dashboardCard(Icons.add_business, 'Tous nos Services',
          () => _navigateTo(context, ServicesPage())),
    ];

    if (role == ROLE_ENUM.client) {
      return clientCards;
    }

    final additionalCards = [
      // _dashboardCard(Icons.calendar_today, 'Disponibilités',
      //     () => _navigateTo(context, const DisponibilitePage())),
      _dashboardCard(Icons.add_circle_outline, 'Ajouter un Service',
          () => _navigateTo(context, AddServicePage())),
    ];

    return clientCards + additionalCards;
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
