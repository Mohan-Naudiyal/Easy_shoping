// lib/services/google_auth_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user-model.dart';
import '../screens/auth_ui/welcome_screen.dart';
import '../screens/user_panel/main_screen.dart';

class GoogleAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        UserModel userModel = UserModel(
          uId: user.uid,
          username: user.displayName.toString(),
          email: user.email.toString(),
          phone: user.phoneNumber.toString(),
          userImg: '',
          userDeviceToken: "",
          country: '',
          userAddress: '',
          street: '',
          isAdmin: false,
          isActive: true,
          createdOn: DateTime.now(),
        );
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set(userModel.toMap());

        Get.off(() => WelcomeScreen()) ;

      }

    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Google Sign-Out Error: $e');
    }
  }

  // Optional: Check if user is already signed in
  Future<bool> isAlreadySignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
