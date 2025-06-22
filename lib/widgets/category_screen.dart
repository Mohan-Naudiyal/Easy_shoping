import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay_shoping/utils/app_constants.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories"), centerTitle: true,
      backgroundColor: AppConstants.appSecondryColor,),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("categories").get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return Container(
              height: 400,
              child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  CategoryModel categoryModel = CategoryModel(
                    categoryId: snapshot.data!.docs[index]["categoryId"],
                    categoryImg: snapshot.data!.docs[index]["categoryImg"],
                    categoryName: snapshot.data!.docs[index]["categoryName"],
                    createAt: snapshot.data!.docs[index]["createAt"],
                    updateAt: snapshot.data!.docs[index]["updateAt"],
                  );
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 8,
                          ),
                          child: Container(
                            width: 180,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    categoryModel.categoryImg,
                                    height: 100,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Center(child: Text(categoryModel.categoryName)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
