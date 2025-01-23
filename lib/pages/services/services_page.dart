import 'package:flutter/material.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/pages/addservice.dart';
import 'package:my_service/pages/base_page.dart';
import 'package:my_service/pages/services/detail/detail_page.dart';
import 'dart:convert';

import 'package:my_service/utils/shared_preferences.dart';

class ServicesPage extends StatefulWidget {
  ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Service> services = []; // List to hold all services
  List<Service> filteredServices = []; // List to hold filtered services

  @override
  void initState() {
    super.initState();
    fetchServices();
    _searchController.addListener(() {
      filterServices();
    });
  }

  // Function to fetch services
  void fetchServices() async {
    final serviceDAO = ServiceDAO();
    final List<Service> allServices = await serviceDAO.getAllServices();
    print("allServices[0].image");

    setState(() {
      services = allServices;
      filteredServices = allServices; // Initially show all services
    });
  }

  // Function to filter services based on search query
  void filterServices() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredServices = services.where((service) {
        // Check if the service name or description contains the search query
        return service.nom?.toLowerCase().contains(query) == true ||
            service.description?.toLowerCase().contains(query) == true;
      }).toList();
    });
  }

  // Function to handle pull-to-refresh
  Future<void> _onRefresh() async {
    fetchServices();
  }

  // Get the stored user ID
  Future<String?> getUserId() async {
    return await SharedPreferencesHelper.getValue('userId');
  }

  void deleteService(Service? service) async {
    final String? userId = await getUserId();
    final serviceDAO = ServiceDAO();
    serviceDAO.deleteServiceById("${service?.id}");
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Services",
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                const SizedBox(height: 20),
                Text(
                  "Our Services",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                // Show a loading indicator while services are being fetched
                if (filteredServices.isEmpty &&
                    _searchController.text.isNotEmpty)
                  Center(
                    child: Text(
                      "No result found",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else if (filteredServices.isEmpty)
                  Center(child: CircularProgressIndicator())
                else
                  // Display the filtered services list
                  ...filteredServices.map((service) {
                    print(service);
                    return _buildServiceCard(service);
                  }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Search services...",
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Service Card Widget
 Widget _buildServiceCard(Service service) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Image and Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Image Placeholder
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: service.image != null && service.image!.isNotEmpty
                    ? Image.memory(
                        base64Decode(service.image!),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      ),
              ),
              const SizedBox(width: 16),
              // Service Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.nom ?? 'No Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.description ?? 'No Description',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      service.disponibilite ?? 'No Availability',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Buttons (View, Delete, Update) aligned at the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ServiceDetailPage(service: service);
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("View",
                          style: TextStyle(color : Colors.white),),
              ),
              FutureBuilder<String?>(
                future: getUserId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final userId = snapshot.data;

                  if (service.cree_par == userId) {
                    return Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddServicePage(service: service);
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Update",
                          style: TextStyle(color : Colors.white),),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            deleteService(service);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Delete",
                          style: TextStyle(color : Colors.white),),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox(); // Empty space if user IDs don't match
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
