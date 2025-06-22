import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay_shoping/models/product_model.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class ProductWedget extends StatefulWidget {
  const ProductWedget({super.key});

  @override
  State<ProductWedget> createState() => _ProductWedgetState();
}

class _ProductWedgetState extends State<ProductWedget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Products").where('isSale', isEqualTo: true).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if(snapshot.hasData){
          return Container(
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductCategury productCategury = ProductCategury(
                    productId: snapshot.data!.docs[index]["productId"],
                    categoryId: snapshot.data!.docs[index]["categoryId"],
                    categoryName: snapshot.data!.docs[index]["categoryName"],
                    isSale: snapshot.data!.docs[index]["isSale"]==true ? true : false,
                    diliveryTime: snapshot.data!.docs[index]["diliveryTime"],
                    updataAt: snapshot.data!.docs[index]["updataAt"],
                    productDescription: snapshot.data!.docs[index]["productDescription"],
                    createdAt: snapshot.data!.docs[index]["createdAt"],
                    fullPrice: snapshot.data!.docs[index]["fullPrice"],
                    Images: List<String>.from(snapshot.data!.docs[index]["Images"]),
                    salePrice: snapshot.data!.docs[index]["salePrice"]
                  );

                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 8)
                            ,child:Container(
                                width: 110,
                                height: 150 ,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20 ),
                                ),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(

                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network( productCategury.Images[0], height: 100, width: double.infinity , fit: BoxFit.cover)),
                                    Text(productCategury.categoryName),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[
                                        Text(productCategury.salePrice.toString()),
                                        SizedBox(width: 5,),
                                        Text(productCategury.fullPrice.toString(),style: TextStyle(decoration: TextDecoration.lineThrough , color: Colors.red), ),
                                      ]
                                    ),
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
    );;
  }
}
