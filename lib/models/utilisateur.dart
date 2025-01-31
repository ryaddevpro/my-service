import 'package:my_service/models/service.dart';

enum ROLE_ENUM { administrateur, prestataire, client }

class Utilisateur {
  final String? id;
  final String? nom;
  final String? email;
  final String? telephone;
  final String? password;
  final ROLE_ENUM? role;
  final String? login;
    final List<Service>? services; // Optional: List of services created by the user

  

  Utilisateur({
    this.id,
    this.nom,
    this.email,
    this.telephone,
    this.password,
    this.role,
    this.login,
        this.services, // Initialize with a list of services created by the user

  });

  // To map data from Supabase to User object
  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['id'],
      nom: json['nom'],
      email: json['email'],
      telephone: json['telephone'],
      password: json['password'],
      role: ROLE_ENUM.values.firstWhere(
        (e) => e.toString() == 'ROLE_ENUM.${json['role']}',
        orElse: () => ROLE_ENUM.client, // Default to 'client' if role is invalid
      ),
      login: json['login'],
    );
  }

  // To map User object to a JSON object for Supabase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    // Only include non-null attributes in the JSON
    if (nom != null) {
      data['nom'] = nom;
    }

    if (email != null) {
      data['email'] = email;
    }

    if (telephone != null) {
      data['telephone'] = telephone;
    }

    // Check if password is not null and not empty
    if (password != null && password!.isNotEmpty) {
      data['password'] = password;
    }

    if (role != null) {
      data['role'] = role.toString().split('.').last; // Store only the enum value
    }

    if (login != null) {
      data['login'] = login;
    }

    // Do not include 'id' if it's auto-generated by Supabase
    return data;
  }
}
