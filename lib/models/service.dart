class Service {
  final String? id;
  final String? nom;
  final String? description;
  final String? categorie;
  final String? cree_par;
  final double? prix;
  final String? image;
  final String? disponibilite;
  


  Service(
      {this.id,
      this.nom,
      this.description,
      this.categorie,
      this.cree_par,
      this.image,
      this.prix,
      this.disponibilite});

  // To map data from Supabase to Service object
  // Convert JSON to Service object
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      description: json['description'] ?? '',
      categorie: json['categorie'] ?? '',
      cree_par: json['cree_par'] ?? '',
      image: json['image'] ?? '',
      disponibilite: json['disponibilite'] ?? '',
      prix: json['prix'] is int
          ? (json['prix'] as int).toDouble()
          : json['prix'] as double?,
    );
  }
  // To map Service object to a JSON object for Supabase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (nom != null) {
      data['nom'] = nom;
    }

    if (image != null) {
      data['image'] = image;
    }


 if (disponibilite != null) {
      data['disponibilite'] = disponibilite;
    }

    // Only include the 'id' of 'cree_par' (Utilisateur)
    if (cree_par != null) {
      data['cree_par'] = cree_par;
// Only include the id of Utilisateur
    }
    if (description != null) {
      data['description'] = description;
    }

    if (prix != null) {
      data['prix'] = prix;
    }

    data['categorie'] = categorie;

    return data;
  }

  // Override the toString() method to print meaningful information
  @override
  String toString() {
    return 'Service{id: $id, nom: $nom, description: $description, categorie: $categorie, cree_par: $cree_par}';
  }
}
