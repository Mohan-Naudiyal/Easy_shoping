import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'main_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool _Loading = false;
  FirebaseAuth  _authService = FirebaseAuth.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Admin Panel"),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _Loading = true;
          });
          await _authService.signOut();
          Get.offAll(() => MainScreen());
          setState(() {
            _Loading = false;
          });
        },
        child: Icon(Icons.exit_to_app_outlined),
      ),
    );
  }
}
