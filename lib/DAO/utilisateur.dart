import 'package:my_service/DAO/generic.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/utils/shared_preferences.dart';
import 'package:my_service/utils/snack_msg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UtilisateurDAO {
  final GenericDAO<Utilisateur> _utilisateurDAO =
      GenericDAO<Utilisateur>("utilisateur");

  // Fetch all users
  Future<List<Utilisateur>> getAllUsers() async {
    return await _utilisateurDAO.getAll((json) => Utilisateur.fromJson(json));
  }

  // Fetch a user by email
  Future<Utilisateur?> getUserByEmail(String email) async {
    return await _utilisateurDAO.getByField(
        "email", email, (json) => Utilisateur.fromJson(json));
  }

  // Fetch a user by id
  Future<Utilisateur?> getUserById(String id) async {
    return await _utilisateurDAO.getByField(
        "id", id, (json) => Utilisateur.fromJson(json));
  }

  // Create a user
  Future<bool> createUser(Utilisateur user) async {
    bool isCreated = false;
    isCreated = await _utilisateurDAO.create(user.toJson());

    if (isCreated) {
      showMessage("Bienvenue sur MyService, vous êtes bien inscrit");
      return true;
    } else {
      showMessage("Une erreur est survenu lors de votre inscription",
          isError: true);
      return false;
    }
  }

  // Update a user
  Future<bool> updateUser(String id, Utilisateur user) async {
    // Check if the user exists by ID first
    final existingUser = await getUserById(id);
    if (existingUser == null) {
      showMessage("User not found with the provided ID", isError: true);
      return false;
    }

    // Proceed with the update if the user exists
    return await _utilisateurDAO.update("id", id, user.toJson());
  }

  Future<bool> deleteUser(String email) async {
    // Check if the user exists by email first
    final existingUser = await getUserByEmail(email);
    if (existingUser == null) {
      showMessage("User not found with the provided email", isError: true);
      return false;
    }

    final userId =
        existingUser.id; // Assuming `id` is the user's unique identifier

    // Retrieve reservations made by the user
    final reservations = await Supabase.instance.client
        .from('reservation')
        .select('id')
        .eq('client_id', "${userId}");

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
        .eq('client_id', "${userId}");

    if (reservationDeleteResponse != null) {
      showMessage("Failed to delete related reservations", isError: true);
      return false;
    }

    // Delete related records in the 'service' table
    final serviceDeleteResponse = await Supabase.instance.client
        .from('service')
        .delete()
        .eq('cree_par', "${userId}");

    if (serviceDeleteResponse != null) {
      showMessage("Failed to delete related services", isError: true);
      return false;
    }

    // Proceed with deleting the user
    final userDeleteResponse = await _utilisateurDAO.delete("email", email);

    if (!userDeleteResponse) {
      showMessage("Failed to delete the user", isError: true);
      return false;
    }

    return true;
  }

  // Login handle
  // Login handle
  Future<bool> loginUser(String email, String password) async {
    final existingUser = await getUserByEmail(email);

    if (existingUser == null) {
      showMessage("User not found with the provided email", isError: true);
      return false;
    }

    if (existingUser.password == password) {
      // Store user data using SharedPreferencesHelper
      await SharedPreferencesHelper.storeValue('userId', existingUser.id);
      await SharedPreferencesHelper.storeValue('userName', existingUser.nom);

      await SharedPreferencesHelper.storeValue('user', existingUser);
      print(existingUser.id);

      showMessage("Login successful! Welcome back, ${existingUser.nom}");
      return true;
    } else {
      showMessage("Incorrect password. Please try again.", isError: true);
      return false;
    }
  }
}
