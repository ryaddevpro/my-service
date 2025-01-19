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
  void createNewService() async {
    final userDao = UtilisateurDAO();
    final Utilisateur? userById =
        await userDao.getUserById("ea9b443c-b693-4d82-aea0-ad5f05b898ab");

    if (userById != null) {
      Service s = Service(
        categorie: "categorie 1",
        cree_par: userById.id,
        description: "descipriton ",
        nom: "plombier",
      );

      final serviceDAO = ServiceDAO();
      serviceDAO.createService(s);
      await Future.delayed(Duration(seconds: 5));

      final List<Service> services = await serviceDAO.getAllServices();

      final String? serviceIdDelete = services[0].id;

      // await Future.delayed(Duration(seconds: 5));

      // serviceDAO.deleteServiceById("${serviceIdDelete}");

      // You can now use serviceDAO to perform operations like creating or updating the service
    } else {
      // Handle the case where userById is null (i.e., user not found)
      print("User not found");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    createNewService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: MyApp.scaffoldMessengerKey, // Use the key here

      home: PrestataireDashboard(),
    );
  }
}
