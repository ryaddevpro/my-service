import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  ReservationPage({super.key});

  // Sample reservation data
  final List<Map<String, String>> reservations = [
    {
      'customerName': 'John Doe',
      'service': 'AI Consultation',
      'date': '2025-01-25',
      'time': '10:00 AM',
      'location': 'Room 101, AI Lab',
    },
    {
      'customerName': 'Jane Smith',
      'service': 'Web Design',
      'date': '2025-01-26',
      'time': '2:00 PM',
      'location': 'Room 202, Creative Studio',
    },
    {
      'customerName': 'Mark Wilson',
      'service': 'Marketing Strategy',
      'date': '2025-01-27',
      'time': '1:00 PM',
      'location': 'Room 303, Strategy Center',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage Your Reservations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return _buildReservationCard(reservation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build reservation card
  Widget _buildReservationCard(Map<String, String> reservation) {
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
            Text(
              'Customer: ${reservation['customerName']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Service: ${reservation['service']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${reservation['date']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${reservation['time']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${reservation['location']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //_acceptReservation(reservation);
                  },
                  child: const Text('Accept'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    //_declineReservation(reservation);
                  },
                  child: const Text('Decline'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  /*
  // Function to handle accepting a reservation
  void _acceptReservation(Map<String, String> reservation) {
    // Logic to accept the reservation, such as updating status in a database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Accepted reservation for ${reservation['customerName']}')),
    );
  }

  // Function to handle declining a reservation
  void _declineReservation(Map<String, String> reservation) {
    // Logic to decline the reservation, such as updating status in a database
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Declined reservation for ${reservation['customerName']}')),
    );
  }*/
}
