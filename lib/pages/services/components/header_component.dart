import 'package:flutter/material.dart';
import 'package:my_service/components/search_textfield.dart';
import 'package:my_service/pages/dashboard_page.dart';

class HeaderComponent extends StatelessWidget {
  final TextEditingController searchController;

  const HeaderComponent({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardPage(),
                ),
              );
            },
            child: Icon(
              Icons.person,
              size: 32.0,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: SearchTextField(
              controller: searchController,
              hintText: 'Search users...',
            ),
          ),
          SizedBox(width: 12),
          InkWell(
            onTap: () {
              // Define action for location icon
            },
            child: Icon(
              Icons.location_on,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
