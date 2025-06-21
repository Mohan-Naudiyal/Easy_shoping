import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay_shoping/utils/app_constants.dart';
import 'package:esay_shoping/widgets/caterory_widget.dart';
import 'package:esay_shoping/widgets/drawer_widget.dart';
import 'package:esay_shoping/widgets/heading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/google-sign-in-controller.dart';
import '../../widgets/banner-widget.dart';
import '../auth_ui/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  BannerWidget bannerWidget = BannerWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("V Mart"),
        centerTitle: true,
        backgroundColor: AppConstants.appSecondryColor,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(child: Column(children: [
          SizedBox(height: 10,),

          bannerWidget ,
          HeadingWidget(Heading: "Categories", subHeading: "According to your budget" , onTap: () {},) ,
          CateroryWidget(),
          HeadingWidget(Heading: "Categories", subHeading: "According to your budget" , onTap: () {},) ,

        ])),
      ),
    );
  }
}
