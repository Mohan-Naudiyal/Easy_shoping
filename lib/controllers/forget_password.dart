

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Forget extends GetxController {

  final FirebaseAuth _forgetPasswordauth = FirebaseAuth.instance;
  final FirebaseFirestore _passwordfirestore = FirebaseFirestore.instance;

  Future<void> forgetPassword(String email) async {
    try {
      final userCrendential = await _forgetPasswordauth.sendPasswordResetEmail(email: email);
      Get.snackbar( "Password change request sent", "Please check your email" );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Password reset request failed. Please try again.';
      if (e.code == 'user-not-found') errorMessage = 'Email not registered.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}