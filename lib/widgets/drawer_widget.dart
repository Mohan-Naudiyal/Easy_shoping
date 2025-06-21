import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/google-sign-in-controller.dart';
import '../screens/auth_ui/main_screen.dart';
import '../utils/app_constants.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _Loading = false;
  final GoogleAuthService _authService = GoogleAuthService();

  final email = FirebaseAuth.instance.currentUser?.email ;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 40),
    child: Drawer(
      backgroundColor: AppConstants.appMainColor,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
            child: ListTile(
              title: Text("mohan" ,style: TextStyle(fontSize: 30),),
              subtitle: Text(email.toString()),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Text("M"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
          ),


          ListTile(
             // titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(Icons.home),
            title: Text("Home"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.production_quantity_limits_outlined),
            title: Text("Product"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text("Orders"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: (){

            },
            leading: Icon(Icons.help_center_outlined),
            title: Text("Contact Us"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () async {
              setState(() {
                _Loading = true;
              });
              await _authService.signOutFromGoogle();
              Get.offAll(() => MainScreen());
              setState(() {
                _Loading = false;
              });
            },
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),

        ],
      ),
    ),
    );
  }
}
