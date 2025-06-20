

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getDeviceToken();
  }

  Future<void> _getDeviceToken() async {

    try{
      String? token = await FirebaseMessaging.instance.getToken();
      if(token != null){
        deviceToken = token ;
        update();
      }
    }catch(e){
      Get.snackbar("Error", "Failed to get device token");
    }

  }
}
