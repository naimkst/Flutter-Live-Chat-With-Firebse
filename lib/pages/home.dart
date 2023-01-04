import 'package:chatapp_flutter/pages/login.dart';
import 'package:chatapp_flutter/services/auth_service.dart';
import 'package:chatapp_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GestureDetector(
        onTap: () {
          authService.signOut();
          nextScreen(context, LoginPage());
        },
        child: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
