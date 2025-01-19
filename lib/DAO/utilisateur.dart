import 'package:my_service/DAO/generic.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/utils/snack_msg.dart';

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

  // Delete a user
  Future<bool> deleteUser(String email) async {
    // Check if the user exists by email first
    final existingUser = await getUserByEmail(email);
    if (existingUser == null) {
      showMessage("User not found with the provided email", isError: true);
      return false;
    }

    // Proceed with the deletion if user exists
    return await _utilisateurDAO.delete("email", email);
  }

  // Login handle
  Future<bool> loginUser(String email, String password) async {
    final existingUser = await getUserByEmail(email);

    if (existingUser == null) {
      showMessage("User not found with the provided email", isError: true);
      return false;
    }

    if (existingUser.password == password) {
      showMessage("Login successful! Welcome back, ${existingUser.nom}");
      return true;
    } else {
      showMessage("Incorrect password. Please try again.", isError: true);
      return false;
    }
  }
}
