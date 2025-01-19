import 'package:flutter/material.dart';

class AvisPage extends StatelessWidget {
  AvisPage({super.key});

  // Sample rating data
  final List<Map<String, dynamic>> reviews = [
    {
      'customerName': 'John Doe',
      'rating': 4.5,
      'comment': 'Great service! The job was done quickly and efficiently.',
    },
    {
      'customerName': 'Jane Smith',
      'rating': 3.0,
      'comment': 'The service was okay, but there is room for improvement.',
    },
    {
      'customerName': 'Mark Wilson',
      'rating': 5.0,
      'comment': 'Absolutely amazing! The work exceeded my expectations.',
    },
    {
      'customerName': 'Emily Johnson',
      'rating': 4.0,
      'comment': 'Good work, but the timeline could have been better.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate average rating
    double averageRating = reviews.fold(0.0, (sum, review) => sum + review['rating']);
    averageRating /= reviews.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avis et Évaluations'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Votre Évaluation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildAverageRating(averageRating),
            const SizedBox(height: 30),
            const Text(
              'Commentaires des Clients',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return _buildReviewCard(review);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display average rating
  Widget _buildAverageRating(double averageRating) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow[700], size: 30),
        const SizedBox(width: 10),
        Text(
          averageRating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          '(${reviews.length} avis)',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget to build individual review card
  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 40, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  review['customerName'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 20),
                const SizedBox(width: 5),
                Text(
                  review['rating'].toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review['comment'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
