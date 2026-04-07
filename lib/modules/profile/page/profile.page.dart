import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : Nitin",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Text(
              "DOB : 18/10/2001",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Text(
              "Nationality : India",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
