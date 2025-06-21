import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../models/category_model.dart';

class CateroryWidget extends StatefulWidget {
  const CateroryWidget({super.key});

  @override
  State<CateroryWidget> createState() => _CateroryWidgetState();
}

class _CateroryWidgetState extends State<CateroryWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("categories").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if(snapshot.hasData){
         return Container(
           height: 110,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (context, index) {
               CategoryModel categoryModel = CategoryModel(categoryId: snapshot.data!.docs[index]["categoryId"], categoryImg: snapshot.data!.docs[index]["categoryImg"], categoryName: snapshot.data!.docs[index]["categoryName"], createAt: snapshot.data!.docs[index]["createAt"], updateAt: snapshot.data!.docs[index]["updateAt"]) ;
               return Row(
                 children: [
                   GestureDetector(
                     onTap: (){},
                     child: Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8)
                         ,child:Container(
                          width: 110,
                           height: 300 ,
                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey),
                             borderRadius: BorderRadius.circular(20 ),
                           ),
                           child: Column(
                             children: [
                               ClipRRect(
                                   borderRadius: BorderRadius.circular(20),
                                   child: Image.network(categoryModel.categoryImg , fit: BoxFit.cover)),
                               Center(
                                 child: Text(categoryModel.categoryName),
                               )
                             ],
                           )
                         ) ),
                   )
                 ],
               ) ;
             },
           )


         ) ;
        }
        return Container() ;
      },
    );
  }
}
