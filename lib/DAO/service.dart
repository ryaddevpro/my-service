import 'package:my_service/DAO/generic.dart';
import 'package:my_service/models/service.dart';

class ServiceDAO {
  final GenericDAO<Service> _serviceDAO = GenericDAO<Service>("service");

  // Fetch all services
  Future<List<Service>> getAllServices() async {
    return await _serviceDAO.getAll((json) => Service.fromJson(json));
  }

  // Fetch a service by id
  Future<Service?> getServiceById(String id) async {
    return await _serviceDAO.getByField("id", id, (json) => Service.fromJson(json));
  }

  // Fetch a service by name
  Future<Service?> getServiceByName(String name) async {
    return await _serviceDAO.getByField("nom", name, (json) => Service.fromJson(json));
  }

  // Create a service
  Future<void> createService(Service service) async {
    await _serviceDAO.create(service.toJson());
  }

  // Update a service
  Future<void> updateService(Service service) async {
    await _serviceDAO.update("id", service.id, service.toJson());
  }

  // Delete a service
  Future<void> deleteService(String id) async {
    await _serviceDAO.delete("id", id);
  }
}
