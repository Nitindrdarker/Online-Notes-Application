import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_todo/modules/db.dart';
import 'package:online_todo/modules/home/page/home.page.dart';
import 'package:online_todo/modules/login/provider/login.provider.dart';

class LoginRegisterPage extends ConsumerStatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  ConsumerState<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends ConsumerState<LoginRegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final viewModel = ref.watch(loginProvider.notifier);
    final state = ref.watch(loginProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(state.userName != null ? "Login" : "Register"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              minRadius: 48,
              maxRadius: 100,
              child: Icon(Icons.person, size: 100),
            ),
            LoginField(
              title: 'User Name',
              controller: userNameController,
              hintText: "Enter your name",
            ),
            SizedBox(height: 20),
            LoginField(
              title: "Password",
              controller: passwordController,
              hintText: "Enter your password",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24),
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.register(
                        userNameController.text,
                        passwordController.text,
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool success = await viewModel.login(
                        userNameController.text,
                        passwordController.text,
                      );
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hintText;
  const LoginField({
    super.key,
    required this.title,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("  $title"),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}
