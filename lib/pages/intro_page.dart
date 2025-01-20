import 'package:flutter/material.dart';
import 'package:my_service/DAO/avis.dart';
import 'package:my_service/DAO/reservation.dart';
import 'package:my_service/models/avis.dart';
import 'package:my_service/models/reservation.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/pages/login_page.dart';
import 'package:my_service/pages/register_page.dart';
import 'package:my_service/utils/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final ReservationDAO reservationDAO = ReservationDAO();
  List<Reservation> reservations = [];
  String message = '';
  String? userId;

  late Reservation testReservation; // Use late initialization

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      userId = await SharedPreferencesHelper.getValue("userId");
      setState(() {
        testReservation = Reservation(
          client_id: "ea9b443c-b693-4d82-aea0-ad5f05b898ab",
          date: DateTime.now(),
          prestataire_id: userId, // Set userId here
          statut: RESEVATION_ENUM.EN_ATTENTE,
        );
      });
    });
    getAllReservations();
  }

// Reservation CRUD Start
  Future<void> createReservation() async {
    bool result = await reservationDAO.createReservation(testReservation);
    setState(() {
      message = result
          ? "Reservation created successfully"
          : "Failed to create reservation";
    });
  }

  Future<void> getAllReservations() async {
    List<Reservation> result = await reservationDAO.getAllReservations();
    setState(() {
      reservations = result;
      message = "Fetched ${reservations.length} reservations";
    });
    print("getAllReservations()--------------${result}");
  }

  Future<void> getReservationById() async {
    Reservation? result =
        await reservationDAO.getReservationById("${reservations[0].id}");
    setState(() {
      message = result != null
          ? "Reservation fetched: ${result.statut}"
          : "No reservation found";
    });
    print("getReservationById()--------------${result}");
  }

  Future<void> updateReservation() async {
    Reservation t = Reservation(
        statut: RESEVATION_ENUM.FINI,
        id: "ff04c025-c0be-4a53-bc88-81b1d8b41d57");
    bool result = await reservationDAO.updateReservation(t);
    setState(() {
      message = result
          ? "Reservation updated successfully"
          : "Failed to update reservation";
    });
  }

  Future<void> deleteReservationById() async {
    bool result =
        await reservationDAO.deleteReservationById("${reservations[0].id}");
    setState(() {
      message = result
          ? "Reservation deleted successfully"
          : "Failed to delete reservation";
    });
  }

  // Reservation CRUD End
  // ========================================================================================================================================================================================
  final AvisDAO avisDAO = AvisDAO(); // Add this line

  // Fetch all avis
  Future<void> getAllAvis() async {
    List<Avis> result = await avisDAO.getAllAvis();
    setState(() {
      message = "Fetched ${result.length} avis";
    });
    print("getAllAvis()--------------${result}");
  }

// Fetch avis by id
  Future<void> getAvisById(String id) async {
    Avis? result = await avisDAO.getAvisById(id);
    setState(() {
      message = result != null
          ? "Avis fetched: ${result}" // Assuming `content` is a field in `Avis`
          : "No avis found";
    });
    print("${result}");
  }

  final Avis a = Avis(
    commentaire: "tres bon",
    note: 8,
    reservation_id: "9b6eecdb-256c-4711-9442-1ae634b8c613",
    id: "22587db1-d21f-44f9-824f-3e997eb5c2a1",
  );

// Create avis
  Future<void> createAvis(Avis avis) async {
    bool result = await avisDAO.createAvis(avis);
    setState(() {
      message = result ? "Avis created successfully" : "Failed to create avis";
    });
  }

// Update avis
  Future<void> updateAvis(Avis avis) async {
    bool result = await avisDAO.updateAvis(avis);
    setState(() {
      message = result ? "Avis updated successfully" : "Failed to update avis";
    });
  }

// Delete avis by id
  Future<void> deleteAvisById(String id) async {
    bool result = await avisDAO.deleteAvisById(id);
    setState(() {
      message = result ? "Avis deleted successfully" : "Failed to delete avis";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.only(
                top: 120.0, left: 100.0, right: 100.0, bottom: 80.0),
            child: Image.asset('lib/images/service_logo.png'),
          ),

          // Main text
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "We bring Services to your doorstep with a single click",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Secondary text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Anytime, Anywhere",
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          // Navigate button
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }),
              );
              // createReservation();
              // getAvisById("${a.id}");
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(24.0),
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
