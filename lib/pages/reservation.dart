import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_service/DAO/reservation.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/DAO/utilisateur.dart';
import 'package:my_service/DAO/avis.dart'; // Import the AvisDAO
import 'package:my_service/models/reservation.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:my_service/utils/snack_msg.dart';
import 'package:my_service/models/avis.dart';

class ReservationPage extends StatefulWidget {
  ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final ReservationDAO reservationDAO = ReservationDAO();
  final UtilisateurDAO userDAO = UtilisateurDAO();
  final ServiceDAO serviceDAO = ServiceDAO();
  final AvisDAO avisDAO = AvisDAO(); // Instantiate AvisDAO
  Utilisateur? utilisateur;

  List<Reservation> reservations = [];
  bool isLoading = true; // Track the loading state
  String message = '';
  Map<String?, String?> clientNames = {}; // Store the client names
  bool isUpdating = false; // Track the updating state for the UI
  List<Avis> reviews = []; // Store reviews

  Future<void> getAllReservations() async {
    setState(() {
      isLoading = true;
    });

    List<Reservation> result = await reservationDAO.getAllReservations();
    String userId = await SharedPreferencesHelper.getValue("userId");
    Utilisateur? user = await SharedPreferencesHelper.getUtilisateur("user");

    List<Reservation> filteredReservations = [];

    if (user?.role == ROLE_ENUM.client) {
      filteredReservations = result.where((reservation) {
        return reservation.client_id == userId;
      }).toList();
    } else if (user?.role == ROLE_ENUM.prestataire) {
      filteredReservations = result.where((reservation) {
        return reservation.prestataire_id == userId;
      }).toList();
    }

    setState(() {
      reservations = filteredReservations;
      isLoading = false;
      message = "Fetched ${reservations.length} reservations";
    });

    // Fetch customer names and service details
    for (var reservation in filteredReservations) {
      Utilisateur? user = await userDAO.getUserById("${reservation.client_id}");
      Service? service =
          await serviceDAO.getServiceById("${reservation.service_id}");

      if (user != null && service != null) {
        setState(() {
          clientNames[reservation.client_id] = user.nom;
          clientNames[reservation.service_id] = service.nom;
          reservation.serviceDetails = service;
        });
      }
    }

    // Fetch and store reviews
    List<Avis> a = await avisDAO.getAllAvis();
    reviews.clear(); // Clear previous reviews

    a.forEach((x) async {
      Reservation? r =
          await reservationDAO.getReservationById("${x.reservation_id}");
      if (r?.client_id == userId && x.reservation_id == r?.id) {
        setState(() {
          reviews.add(x); // Store review in the list
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUtilisateur();
  }

  Future<void> _loadUtilisateur() async {
    utilisateur = await SharedPreferencesHelper.getUtilisateur('user');
    await getAllReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: getAllReservations,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Manage Your Reservations ${utilisateur?.nom}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else if (reservations.isEmpty)
                Center(child: Text("No reservations found"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      return _buildReservationCard(reservation);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationCard(Reservation reservation) {
    String customerName =
        clientNames[reservation.client_id] ?? 'Unknown Customer';
    String serviceName = reservation.serviceDetails?.nom ?? 'Unknown Service';
    String serviceImage = reservation.serviceDetails?.image ?? '';
    double servicePrice = reservation.serviceDetails?.prix ?? 0.0;

    TextEditingController commentController = TextEditingController();
    TextEditingController ratingController = TextEditingController();

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Opacity(
          opacity: isUpdating ? 0.6 : 1.0,
          child: AbsorbPointer(
            absorbing: isUpdating,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer: $customerName',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Prestataire: ${reservation.prestataire_id}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Service name: $serviceName',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  if (serviceImage.isNotEmpty)
                    Image.memory(
                      base64Decode(serviceImage),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${servicePrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${reservation.date}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time: ${reservation.date}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${reservation.statut.toString().split('.').last}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Display Reviews
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reviews:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      for (var avis in reviews)
                        if (avis.reservation_id == reservation.id) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rating: ${avis.note} / 5',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Comment: ${avis.commentaire}',
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  // Update Button
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      // Trigger update action
                                      commentController.text =
                                          "${avis.commentaire}";
                                      ratingController.text =
                                          avis.note.toString();
                                      _showUpdateReviewDialog(avis);
                                    },
                                  ),
                                  // Delete Button
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Trigger delete action
                                      _showDeleteReviewDialog(avis);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ]
                    ],
                  ),
                  if (utilisateur?.role != ROLE_ENUM.client)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DropdownButton<RESEVATION_ENUM>(
                                value: reservation.statut,
                                onChanged: isUpdating
                                    ? null
                                    : (RESEVATION_ENUM? newStatus) async {
                                        if (newStatus != null) {
                                          setState(() {
                                            isUpdating = true;
                                            reservation.statut = newStatus;
                                          });

                                          await reservationDAO
                                              .updateReservation(reservation);

                                          await Future.delayed(
                                              const Duration(seconds: 4));
                                          setState(() {
                                            isUpdating = false;
                                          });

                                          showMessage(
                                              "Reservation updated successfully");
                                        }
                                      },
                                items: RESEVATION_ENUM.values
                                    .map((RESEVATION_ENUM statut) {
                                  return DropdownMenuItem<RESEVATION_ENUM>(
                                    value: statut,
                                    child:
                                        Text(statut.toString().split('.').last),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                  // Add comment and rating inputs if client
                  if (utilisateur?.role == ROLE_ENUM.client &&
                      reservation.statut == RESEVATION_ENUM.FINI)
                    Column(
                      children: [
                        TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            labelText: 'Your Comment',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: ratingController,
                          decoration: const InputDecoration(
                            labelText: 'Your Rating (1-5)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            int? rating = int.tryParse(ratingController.text);
                            String comment = commentController.text;
                            if (rating != null && rating >= 1 && rating <= 5) {
                              Avis avis = Avis(
                                commentaire: comment,
                                note: rating,
                                reservation_id: reservation.id,
                              );

                              bool success = await avisDAO.createAvis(avis);
                              if (success) {
                                showMessage("Thank you for your feedback!");
                              }
                            } else {
                              showMessage("Please enter a valid rating (1-5)",
                                  isError: true);
                            }
                          },
                          child: Text("Submit Review"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ));
  }

  // Show Update Review Dialog
  Future<void> _showUpdateReviewDialog(Avis avis) async {
    TextEditingController commentController =
        TextEditingController(text: avis.commentaire);
    TextEditingController ratingController =
        TextEditingController(text: avis.note.toString());

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: InputDecoration(labelText: 'Comment'),
              ),
              TextField(
                controller: ratingController,
                decoration: InputDecoration(labelText: 'Rating (1-5)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                int? rating = int.tryParse(ratingController.text);
                String comment = commentController.text;
                if (rating != null && rating >= 1 && rating <= 5) {
                  avis.commentaire = comment;
                  avis.note = rating;

                  bool success = await avisDAO.updateAvis(avis);
                  if (success) {
                    Navigator.pop(context);
                    showMessage("Review updated successfully");
                    await getAllReservations();
                  }
                } else {
                  showMessage("Please enter a valid rating (1-5)",
                      isError: true);
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Review Dialog
  Future<void> _showDeleteReviewDialog(Avis avis) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Review'),
          content: Text('Are you sure you want to delete this review?'),
          actions: [
            TextButton(
              onPressed: () async {
                bool success = await avisDAO.deleteAvisById("${avis.id}");
                if (success) {
                  Navigator.pop(context);
                  showMessage("Review deleted successfully");
                  await getAllReservations();
                }
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
