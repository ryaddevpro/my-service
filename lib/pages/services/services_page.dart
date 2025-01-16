import 'package:flutter/material.dart';
import 'package:my_service/pages/base_page.dart';
import 'package:my_service/pages/services/components/header_component.dart';
import 'package:my_service/pages/services/components/service_card.dart';
import 'package:my_service/pages/services/components/services_header_buttons.dart';

class ServicesPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  // Sample data to loop through
  final List<Map<String, dynamic>> services = [
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 1',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service1',
      'rating': 4.5, // Example rating
    },
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 2',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service2',
      'rating': 3.0, // Example rating
    },
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 2',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service2',
      'rating': 3.0, // Example rating
    },
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 2',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service2',
      'rating': 3.0, // Example rating
    },
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 2',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service2',
      'rating': 3.0, // Example rating
    },
    {
      'imageUrl':
          'https://www.powertrafic.fr/wp-content/uploads/2023/04/image-ia-exemple.png',
      'productName': 'AI Service 2',
      'productDescription':
          'Description of AI Service Description of AI Service Description of AI Service2',
      'rating': 3.0, // Example rating
    },
    // Add more services as needed
  ];

  ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Services",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderComponent(searchController: _searchController),
              ServicesHeaderButtons(),
              // Loop through services and create a card for each one
              for (int i = 0; i < services.length; i++)
                ServiceCard(
                  imageUrl: services[i]['imageUrl']!,
                  productName: services[i]['productName']!,
                  productDescription: services[i]['productDescription']!,
                  rating: services[i]['rating']!, // Pass rating
                  index: i, // Pass the index to make the tag unique
                ),
            ],
          ),
        ),
      ),
    );
  }
}
