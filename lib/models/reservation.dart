import 'package:my_service/models/avis.dart';
import 'package:my_service/models/service.dart';

enum RESEVATION_ENUM { EN_ATTENTE, EN_COURS, FINI, REFUSE }

class Reservation {
  final String? id;
  final String? client_id;
  final String? prestataire_id;
  final DateTime? date;
  final String? service_id;
  RESEVATION_ENUM? statut; // Enum for reservation status
  Service? serviceDetails; // Add this field to store the service details
  List<Avis>? avisList = []; // Add this field to store reviews

  // Constructor
  Reservation({
    this.id,
    this.client_id,
    this.prestataire_id,
    this.date,
    this.statut,
    this.serviceDetails,
    this.service_id,
    this.avisList = const [],
  });

  // From JSON`
  factory Reservation.fromJson(Map<String, dynamic> json) {
    print(json);
    return Reservation(
      id: json['id'],
      client_id: json['client_id'],
      prestataire_id: json['prestataire_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      service_id: json['service_id'],
      statut: RESEVATION_ENUM.values.firstWhere(
        (e) => e.toString() == 'RESEVATION_ENUM.${json['statut']}',
        orElse: () => RESEVATION_ENUM
            .EN_ATTENTE, // Default to 'client' if role is invalid
      ),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    // Only include non-null attributes in the JSON
    if (id != null) {
      data['id'] = id;
    }
    if (client_id != null) {
      data['client_id'] = client_id;
    }
    if (service_id != null) {
      data['service_id'] = service_id;
    }
    if (prestataire_id != null) {
      data['prestataire_id'] = prestataire_id;
    }
    if (date != null) {
      data['date'] = date?.toIso8601String();
    }

    // Store the status as the enum value
    if (statut != null) {
      data['statut'] =
          statut.toString().split('.').last; // Store only the enum value
    }

    return data;
  }

  @override
  String toString() {
    return 'Reservation{id: $id, client_id: $client_id, prestataire_id: $prestataire_id, date: $date, statut: $statut, service_id: $service_id}';
  }
}
