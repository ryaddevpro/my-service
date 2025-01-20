class Avis {
  final String? id;
  String? commentaire;
  final String? reservation_id;
  int? note;

  Avis({
    this.id,
    this.commentaire,
    this.reservation_id,
    this.note,
  });

  // To map data from Supabase to Avis object
  // Convert JSON to Avis object
  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      id: json['id'] ?? '',
      commentaire: json['commentaire'] ?? '',
      reservation_id: json['reservation_id'] ?? '',
      note: json['note'] ?? '',
    );
  }
  // To map Avis object to a JSON object for Supabase
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (id != null) {
      data['id'] = id;
    }

    if (commentaire != null) {
      data['commentaire'] = commentaire;
    }

    if (reservation_id != null) {
      data['reservation_id'] = reservation_id;
    }

    if (note != null) {
      data['note'] = note;
    }

    return data;
  }

  // Override the toString() method to print meaningful information
  @override
  String toString() {
    return 'Avis(id: $id, commentaire: $commentaire, reservation_id: $reservation_id, note: $note)';
  }
}
