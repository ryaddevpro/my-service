import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_service/DAO/avis.dart';
import 'package:my_service/DAO/reservation.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/models/avis.dart';
import 'package:my_service/models/reservation.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class ServiceDetailPage extends StatefulWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final ReservationDAO reservationDAO = ReservationDAO();
  final ServiceDAO serviceDAO = ServiceDAO();
  final AvisDAO avisDAO = AvisDAO();
  List<Reservation> reservations = [];
  List<Avis> aviss = [];
  List<Service> services = [];
  String message = '';
  String? userId;

  late Reservation testReservation;
  DateTime? selectedDate;

  bool isAbleToPickReservation = false;
  bool hasReservation = false; // New flag

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      userId = await SharedPreferencesHelper.getValue("userId");
      if (userId != null) {
        hasReservation =
            await hasExistingReservation(userId!, widget.service.id!);
      }
      setState(() {});
    });
    getAllAvis();
  }

  Future<void> getAllAvis() async {
    List<Avis> result = await avisDAO.getAllAvis();
    setState(() {
      message = "Fetched ${result.length} avis";
    });
    List<Tuple3<Avis, Reservation, Service>> avisReservationServices = [];
    List<Future> allFutures = [];
    String? desiredServiceId = widget.service.id;

    for (var avis in result) {
      Future<Reservation?> reservationFuture =
          getReservationById(avis.reservation_id);

      allFutures.add(reservationFuture.then((reservation) {
        isAbleToPickReservation = false;
        if (reservation != null && reservation.service_id == desiredServiceId) {
          return serviceDAO
              .getServiceById("${reservation.service_id}")
              .then((service) {
            if (service != null) {
              avisReservationServices.add(Tuple3(avis, reservation, service));
            }
          });
        }
        return null;
      }));
    }
    await Future.wait(allFutures);
    setState(() {
      aviss = avisReservationServices.map((tuple) => tuple.item1).toList();
    });
  }

  Future<void> getAllReservations() async {
    List<Reservation> result = await reservationDAO.getAllReservations();
    setState(() {
      reservations = result;
      message = "Fetched ${reservations.length} reservations";
    });
  }

  Future<Reservation?> getReservationById(String? reservationId) async {
    Reservation? result =
        await reservationDAO.getReservationById("$reservationId");
    setState(() {
      message = result != null
          ? "Reservation fetched: ${result.statut}"
          : "No reservation found";
    });
    return result;
  }

  Widget _base64ToImage(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes,
        height: 200, width: double.infinity, fit: BoxFit.cover);
  }

  // Function to open date picker modal
  Future<void> _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<bool> hasExistingReservation(String userId, String serviceId) async {
    List<Reservation> reservations = await reservationDAO.getAllReservations();
    return reservations.any((reservation) =>
        reservation.client_id == userId &&
        reservation.service_id == serviceId &&
        reservation.statut != RESEVATION_ENUM.FINI);
  }

  // Function to reserve service (after date is picked)
  void _reserveService() async {
    if (selectedDate != null) {
      if (await hasExistingReservation(userId!, widget.service.id!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('You already have a reservation for this service.')),
        );
        return;
      }

      Reservation newReservation = Reservation(
        client_id: userId,
        date: selectedDate,
        prestataire_id: widget.service.cree_par,
        service_id: widget.service.id,
        statut: RESEVATION_ENUM.EN_ATTENTE,
      );

      bool res = await reservationDAO.createReservation(newReservation);
      
      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Service reserved for ${selectedDate!.toLocal()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date to reserve.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.service.nom}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _base64ToImage(widget.service.image!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.service.nom}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${widget.service.description}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Avis des utilisateurs",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ...aviss.map((avis) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              "${avis.commentaire}",
                              style: TextStyle(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                          )),
                      SizedBox(height: 16),
                    ],
                  ),
                  SizedBox(height: 16),

                  if (hasReservation)
                    Text(
                      "You already have a reservation for this service.",
                      style: TextStyle(color: Colors.red),
                    ),
                  // Check if the service was created by the current user, hide the buttons if true
                  if (!hasReservation && widget.service.cree_par != userId) ...[
                    ElevatedButton(
                      onPressed: hasReservation ? null : _openDatePicker,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("Sélectionner une date et Réserver"),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: hasReservation ? null : _reserveService,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Text("Confirmer la réservation"),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
