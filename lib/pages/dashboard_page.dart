import 'package:flutter/material.dart';
import 'package:my_service/components/chart/chart_container.dart';
import 'package:my_service/components/chart/line_chart_content.dart';
import 'package:my_service/components/search_textfield.dart';
import 'package:my_service/pages/base_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> users = [
    {
      'name': 'user 1',
      'email': 'user1@gmail.com',
      'imageUrl':
          'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png',
    },
    {
      'name': 'user 2',
      'email': 'user2@gmail.com',
      'imageUrl':
          'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png',
    },
    {
      'name': 'user 3',
      'email': 'user3@gmail.com',
      'imageUrl':
          'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png',
    },
    // Add more user data as needed
  ];

  List<Map<String, String>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = users; // Initialize with all users
    _searchController
        .addListener(_onSearchChanged); // Listen for search changes
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users
          .where((user) =>
              user['name']!.toLowerCase().contains(query) ||
              user['email']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "DashBoard",
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Color(0xfff0f0f0),
            child: Column(
              children: <Widget>[
                ChartContainer(
                  title: 'Revenue Montuelle',
                  color: Color.fromRGBO(45, 108, 223, 1),
                  chart: LineChartContent(),
                ),
                SizedBox(height: 25.0),
                Row(
                  children: [
                    Text(
                      "Tous les Utilisateurs",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SearchTextField(
                  controller: _searchController,
                  hintText: "Rechercher un utilisateur...",
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.circular(4),
                        child: InkWell(
                          onTap: () {
                            print("${user['name']} clicked");
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text(user['name']!),
                            subtitle: Text(user['email']!),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(80.9),
                              child: Image.network(user['imageUrl']!),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
