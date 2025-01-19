import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_service/DAO/service.dart';
import 'package:my_service/DAO/utilisateur.dart';
import 'package:my_service/models/service.dart';
import 'package:my_service/models/utilisateur.dart';
import 'package:my_service/pages/intro_page.dart';
import 'package:my_service/pages/prestataire_dashboard.dart';
import 'package:my_service/pages/services/services_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:my_service/pages/services/services_page.dart';

void main() async {
  await dotenv.load(); // Load environment variables
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // Define a GlobalKey for ScaffoldMessenger
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey, // Use the key here

      home: ServicesPage(),
    );
  }
}
