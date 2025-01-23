import 'package:my_service/DAO/generic.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/utils/snack_msg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ServiceDAO {
  final GenericDAO<Service> _serviceDAO = GenericDAO<Service>("service");

  // Fetch all services
  Future<List<Service>> getAllServices() async {
    try {
      List<Service> ls =
          await _serviceDAO.getAll((json) => Service.fromJson(json));
      print("ls+++++++");
      print(ls);
      return ls;
    } catch (e) {
      showMessage(
          "Une erreur est survenue lors de la récupération des services",
          isError: true);
      print("Error in getAllServices()");
      print(e);
      return [];
    }
  }

  // Fetch a service by id
  Future<Service?> getServiceById(String id) async {
    try {
      return await _serviceDAO.getByField(
          "id", id, (json) => Service.fromJson(json));
    } catch (e) {
      showMessage("Une erreur est survenue lors de la récupération du service",
          isError: true);
      return null;
    }
  }

  // Fetch a service by name
  Future<Service?> getServiceByName(String name) async {
    try {
      return await _serviceDAO.getByField(
          "nom", name, (json) => Service.fromJson(json));
    } catch (e) {
      showMessage(
          "Une erreur est survenue lors de la récupération du service par nom",
          isError: true);
      return null;
    }
  }

  // Create a service
  Future<bool> createService(Service service) async {
    try {
      await _serviceDAO.create(service.toJson());
      showMessage("Service créé avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la création du service",
          isError: true);
      return false;
    }
  }

  // Update a service
  Future<bool> updateService(Service service) async {
    try {
      await _serviceDAO.update("id", service.id, service.toJson());
      showMessage("Service mis à jour avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la mise à jour du service",
          isError: true);
      return false;
    }
  }

  Future<bool> deleteServiceById(String id) async {
    try {
      // Fetch reservations related to the service
      final reservations = await Supabase.instance.client
          .from('reservation')
          .select('id')
          .eq('service_id', id);

      for (var reservation in reservations) {
        final reservationId = reservation['id'];

        // Delete related 'avis' entries first
        final avisDeleteResponse = await Supabase.instance.client
            .from('avis')
            .delete()
            .eq('reservation_id', reservationId);

        if (avisDeleteResponse != null) {
          showMessage(
              "Failed to delete related avis for reservation $reservationId",
              isError: true);
          return false;
        }
      }

      // After deleting 'avis' entries, delete 'reservation' entries
      final reservationDeleteResponse = await Supabase.instance.client
          .from('reservation')
          .delete()
          .eq('service_id', id);

      if (reservationDeleteResponse != null) {
        showMessage("Failed to delete related reservations", isError: true);
        return false;
      }

      // Proceed with deleting the service
      await _serviceDAO.delete("id", id);
      showMessage("Service supprimé avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la suppression du service",
          isError: true);
      print(e);
      return false;
    }
  }
}
