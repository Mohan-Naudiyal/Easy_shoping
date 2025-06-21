import 'package:flutter/material.dart';
class HeadingWidget extends StatelessWidget {
  String Heading ;
  String subHeading ;
  final VoidCallback onTap;
   HeadingWidget({super.key , required this.Heading , required this.subHeading ,required this.onTap });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 15 ,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Heading ,style:  TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              Text(subHeading ,style:  TextStyle(fontSize: 13 , fontWeight: FontWeight.w300 ,color: Colors.grey)),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red),
              ),
              child:  Text("View All >"),
            ),
          )
        ],

      ),),
    );
  }
}
