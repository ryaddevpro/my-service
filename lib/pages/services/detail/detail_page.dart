import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_service/models/service.dart';

class ServiceDetailPage extends StatefulWidget {
  final Service service;

  const ServiceDetailPage({super.key, required this.service});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  // Function to convert base64 string to Image
  Widget _base64ToImage(String base64String) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(bytes,
        height: 200, width: double.infinity, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.service.nom}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _base64ToImage(widget.service.image!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.service.nom}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${widget.service.description}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  // Text(
                  //   'Rating: $rating',
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
