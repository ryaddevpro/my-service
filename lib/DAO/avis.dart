import 'package:my_service/DAO/generic.dart';
import 'package:my_service/models/avis.dart';
import 'package:my_service/utils/snack_msg.dart';

class AvisDAO {
  final GenericDAO<Avis> _avisDAO = GenericDAO<Avis>("avis");

  // Fetch all Avis
  Future<List<Avis>> getAllAvis() async {
    try {
      List<Avis> avisList =
          await _avisDAO.getAll((json) => Avis.fromJson(json));
      return avisList;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la récupération des avis",
          isError: true);
      return [];
    }
  }

  // Fetch an Avis by id
  Future<Avis?> getAvisById(String id) async {
    try {
      return await _avisDAO.getByField("id", id, (json) => Avis.fromJson(json));
    } catch (e) {
      showMessage("Une erreur est survenue lors de la récupération de l'avis",
          isError: true);
      return null;
    }
  }

  // Create an Avis
  Future<bool> createAvis(Avis avis) async {
    try {
      await _avisDAO.create(avis.toJson());
      showMessage("Avis créé avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la création de l'avis",
          isError: true);
      return false;
    }
  }

  // Update an Avis
  Future<bool> updateAvis(Avis avis) async {
    try {
      await _avisDAO.update("id", avis.id, avis.toJson());
      showMessage("Avis mis à jour avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la mise à jour de l'avis",
          isError: true);
      return false;
    }
  }

  // Delete an Avis
  Future<bool> deleteAvisById(String id) async {
    try {
      await _avisDAO.delete("id", id);
      showMessage("Avis supprimé avec succès");
      return true;
    } catch (e) {
      showMessage("Une erreur est survenue lors de la suppression de l'avis",
          isError: true);
      return false;
    }
  }

}
