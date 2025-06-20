
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay_shoping/models/user-model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginService extends GetxController {
    final FirebaseAuth _loginAuth = FirebaseAuth.instance ;
    final FirebaseFirestore _loginFirestore = FirebaseFirestore.instance ;

    Future<UserModel> loginUser(String email , String password) async {
      try{
        UserCredential credential = await _loginAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
        if(credential.user!.emailVerified){
          await credential.user!.sendEmailVerification();
          throw 'Please verify your email first. We sent a new verification link.';
        }
        final userDoc = await _loginFirestore.collection("users").doc(credential.user!.uid).get();
        if(userDoc.exists){
          return UserModel.fromMap(userDoc.data()!) ;
        }
        else{
          throw 'User data not found';
        }


      } on FirebaseAuthException catch(e){
        String errorMessage = 'Login failed. Please try again.';
        if(e.code== "user-not-found")  errorMessage = 'Email not registered.';
        if(e.code== "wrong-password")  errorMessage = 'Incorrect password.';
        throw Exception(errorMessage);
      }
      catch(e){
        throw Exception('Error: ${e.toString()}');
      }

      }
    }

