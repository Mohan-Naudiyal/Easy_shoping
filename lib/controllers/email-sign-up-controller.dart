import 'package:esay_shoping/controllers/token_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/user-model.dart';

class RegistrationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GetDeviceTokenController deviceTokenController = Get.put(GetDeviceTokenController()) ;

  // ========== 2. Registration Method ==========
  Future<UserModel> registerUser({
    required String email,
    required String password,
    required String username,
    required String phone,
    required String userImg ,
    required String country,
    required String userAddress,
    required String street,
    required bool isAdmin,
    required bool isActive,
    required DateTime createdOn,
    required String city,
  }) async {

    try {
      // 1. Create auth account
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
      }

      // 2. Create user data model
      UserModel newUser = UserModel(
        uId: credential.user!.uid,
        username: username,
        email: email,
        phone: phone,
        userImg: "",
        userDeviceToken: deviceTokenController.deviceToken.toString() ,
        country: "",
        userAddress: "",
        street: "",
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
        city: city,
      );

      // 3. Save to Firestore
      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(newUser.toMap());

      return newUser;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed.';
      if (e.code == 'weak-password')
        errorMessage = 'Password too weak (min 6 chars).';
      if (e.code == 'email-already-in-use')
        errorMessage = 'Email already registered.';
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  // ========== 3. Get Current User ==========
  Future<UserModel?> getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(user.uid).get();
    return doc.exists
        ? UserModel.fromMap(doc.data() as Map<String, dynamic>)
        : null;
  }

  // ========== 4. Sign Out ==========
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
