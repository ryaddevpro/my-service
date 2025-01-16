import 'package:flutter/material.dart';

class ServicesHeaderButtons extends StatelessWidget {
  const ServicesHeaderButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton(
              onPressed: () {},
              child: Text(
                "explorer",
                style: TextStyle(color: Colors.black87, fontSize: 24),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Historique",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
