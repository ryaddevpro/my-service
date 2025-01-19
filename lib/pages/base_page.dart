import 'package:flutter/material.dart';
import 'package:my_service/pages/services/services_page.dart';
import 'package:my_service/pages/dashboard_page.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String title;

  const BasePage({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.grey[300],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SafeArea(
              child: ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ));
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_business),
              title: const Text('Descouvrir nos Services'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicesPage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
