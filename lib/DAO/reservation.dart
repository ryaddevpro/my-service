  import 'package:my_service/DAO/generic.dart';
  import 'package:my_service/models/reservation.dart';
  import 'package:my_service/utils/snack_msg.dart';

  class ReservationDAO {
    final GenericDAO<Reservation> _reservationDAO =
        GenericDAO<Reservation>("reservation");

    // Fetch all reservations
    Future<List<Reservation>> getAllReservations() async {
      try {
        List<Reservation> reservations =
            await _reservationDAO.getAll((json) => Reservation.fromJson(json));
        return reservations;
      } catch (e) {
        showMessage(
            "Une erreur est survenue lors de la récupération des réservations",
            isError: true);
        return [];
      }
    }

    // Fetch a reservation by id
    Future<Reservation?> getReservationById(String id) async {
      try {
        return await _reservationDAO.getByField(
            "id", id, (json) => Reservation.fromJson(json));
      } catch (e) {
        showMessage(
            "Une erreur est survenue lors de la récupération de la réservation",
            isError: true);
        return null;
      }
    }

    // Create a reservation
    Future<bool> createReservation(Reservation reservation) async {
      try {
        await _reservationDAO.create(reservation.toJson());
        Future.delayed(Duration(seconds: 4));
        showMessage("Réservation créée avec succès");
        return true;
      } catch (e) {
        showMessage(
            "Une erreur est survenue lors de la création de la réservation",
            isError: true);
        return false;
      }
    }

  // Update a reservation
    // Update a reservation
    Future<bool> updateReservation(Reservation reservation) async {
      try {
        // Try to update the reservation and check the response
        final response = await _reservationDAO.update(
          "id",
          reservation.id,
          reservation.toJson(),
        );

        showMessage("Réservation mise à jour avec succès");

        return response;
      } catch (e) {
        // If an error occurs, print the error and retry the operation
        showMessage("Échec de la mise à jour de la réservation", isError: true);
        return false;
      }
    }

    // Delete a reservation
    Future<bool> deleteReservationById(String id) async {
      try {
        await _reservationDAO.delete("id", id);
        showMessage("Réservation supprimée avec succès");
        return true;
      } catch (e) {
        showMessage(
            "Une erreur est survenue lors de la suppression de la réservation",
            isError: true);
        return false;
      }
    }
  }
