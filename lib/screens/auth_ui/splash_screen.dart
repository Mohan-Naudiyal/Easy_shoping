import 'dart:async';



import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_constants.dart';
import '../user_panel/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen() )) ;
    }) ;
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
