import 'package:flutter/material.dart';
import 'package:online_todo/modules/db.dart';

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
              "Name : ${username}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
            Text(
              "Token : ${jwtToken}",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
