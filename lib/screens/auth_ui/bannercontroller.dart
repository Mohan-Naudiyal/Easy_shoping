

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

  RxList<String> banners = RxList<String>([]) ;
  @override
  onInit() {
    super.onInit();
    fatchBanners();
  }
  Future<void> fatchBanners() async {
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("banners").get();
      if(snapshot.docs.isNotEmpty) {
        banners.value = snapshot.docs.map((e) => e['img'] as String).toList();
      }
    }catch(e){
      print( "error in fetching banners" + e.toString());

    }
  }
}