import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class GetUserDataController extends GetxController {
   FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData(String uId) async {
    try {
      final doc = await _firestore.collection('users').doc(uId).get();
      if (!doc.exists) throw Exception('User data not found');
      return doc.data()!;
    } catch (e) {
      throw Exception('Failed to get user data: ${e.toString()}');
    }
  }
}