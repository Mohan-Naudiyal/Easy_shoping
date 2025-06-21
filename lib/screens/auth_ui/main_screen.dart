
import 'package:esay_shoping/screens/auth_ui/Login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/google-sign-in-controller.dart';
import '../../utils/app_constants.dart';
import '../../widgets/drawer_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  final GoogleAuthService _authService = GoogleAuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final UserCredential? userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sign in with Google Successful"))) ;
      }
    } finally {
      setState(() => _isLoading = false);
    }


  }


  // bool _isLoading = false;
  //
  // Future<void> signInWithGoogle() async {
  //   try {
  //     setState(() => _isLoading = true);
  //
  //     // Trigger the authentication flow
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     if (googleUser == null) {
  //       // User canceled the sign-in
  //       setState(() => _isLoading = false);
  //       return;
  //     }
  //
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
  //
  //     // Create a new credential
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     // Sign in to Firebase with the Google credential
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen() )) ;
  //
  //   } catch (e) {
  //     setState(() => _isLoading = false);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error signing in with Google: ${e.toString()}')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appMainColor,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(color: AppConstants.appMainColor),
                  child: Lottie.asset(
                    "assets/images/splash.json",
                    width: 500,
                    height: 200,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Welcome E Mart",
                  style: TextStyle(
                    color: AppConstants.appSecondryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 50),
                InkWell(
                  // onTap: _isLoading ? null : () => signInWithGoogle(),

                  onTap: _isLoading ? null : _handleGoogleSignIn,

                  child: Container(
                    width: 350,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppConstants.appMainColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Google.png",
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Login with Google",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppConstants.apptextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: _isLoading ? null : () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login())) ;
                  },
                  child: Container(
                    width: 350,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppConstants.appSecondryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email_outlined, size: 38),
                        SizedBox(width: 20),
                        Text(
                          "Login with Email",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppConstants.apptextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}