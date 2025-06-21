import 'dart:async';



import 'package:esay_shoping/controllers/get-user-data-Controller.dart';
import 'package:esay_shoping/screens/user_panel/user_screen.dart';
import 'package:esay_shoping/screens/user_panel/admin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_constants.dart';
import 'main_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser ;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), (){
      loggdIn(context) ;
    }) ;
  }

  Future<void>loggdIn(BuildContext context) async {

    if( user != null){
      final GetUserDataController getUserDataController = Get.put(GetUserDataController()) ;
      var userData = await getUserDataController.getUserData(user!.uid);
      if(userData['isAdmin'] == "true"){
        Get.to(() => AdminScreen()) ;
      }else{
        Get.to(() => WelcomeScreen()) ;
      }
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appSecondryColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: Get.width ,
              margin: EdgeInsets.only(top: 300),

              alignment: Alignment.center,
              child: Lottie.asset(
                "assets/images/splash.json",
                width: 400,
                height: 200,
              ),
            ),
            SizedBox(height: 20,),
            
            Container(
              // width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstants.mainAppName,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold , color: const Color.fromARGB(255, 103, 39, 39)),
              ),
            ),
            
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 300),
                child: Text(
                  AppConstants.powerBy,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
