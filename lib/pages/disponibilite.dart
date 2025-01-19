import 'package:flutter/material.dart';

class DisponibilitePage extends StatefulWidget {
  const DisponibilitePage({super.key});

  @override
  _DisponibilitePageState createState() => _DisponibilitePageState();
}

class _DisponibilitePageState extends State<DisponibilitePage> {
  // Map to store availability for each day
  Map<String, TimeOfDay> startTimes = {};
  Map<String, TimeOfDay> endTimes = {};
  Map<String, bool> availability = {};

  // List of weekdays
  final List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize all days as unavailable and with default times
    for (var day in daysOfWeek) {
      availability[day] = false;
      startTimes[day] = TimeOfDay(hour: 9, minute: 0); // default start time (9:00 AM)
      endTimes[day] = TimeOfDay(hour: 17, minute: 0); // default end time (5:00 PM)
    }
  }

  void _saveAvailability() {
    // You can save this data to a database or perform other actions as needed.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Availability saved successfully!')),
    );
  }

  // Function to select start time
  Future<void> _selectStartTime(BuildContext context, String day) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTimes[day]!,
    );
    if (picked != null && picked != startTimes[day]) {
      setState(() {
        startTimes[day] = picked;
      });
    }
  }

  // Function to select end time
  Future<void> _selectEndTime(BuildContext context, String day) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTimes[day]!,
    );
    if (picked != null && picked != endTimes[day]) {
      setState(() {
        endTimes[day] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disponibilité'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set Your Availability',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  for (var day in daysOfWeek)
                    _buildDayAvailability(day),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveAvailability,
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build availability options for each day
  Widget _buildDayAvailability(String day) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Start: ${startTimes[day]!.format(context)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectStartTime(context, day),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'End: ${endTimes[day]!.format(context)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectEndTime(context, day),
                    ),
                  ],
                ),
              ],
            ),
            Switch(
              value: availability[day]!,
              onChanged: (bool value) {
                setState(() {
                  availability[day] = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
