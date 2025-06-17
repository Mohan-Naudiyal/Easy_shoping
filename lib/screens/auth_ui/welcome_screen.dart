
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/google-sign-in-controller.dart';
import '../user_panel/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final GoogleAuthService _authService = GoogleAuthService() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Maohan Naudiyal"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
       await _authService.signOutFromGoogle() ;
        Get.offAll(() => MainScreen()) ;
      } , child: Icon(Icons.exit_to_app_outlined), ),
    );
  }
}
