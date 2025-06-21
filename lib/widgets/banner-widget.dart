import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../screens/auth_ui/bannercontroller.dart';
class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannerController bannerController = Get.put(BannerController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return CarouselSlider(
          items: bannerController.banners.map((imgUrl) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return ColoredBox(
                    color: Colors.white,
                    child: Center(child: CupertinoActivityIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200, // You can adjust this
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            scrollDirection: Axis.horizontal ,
          ),
        );
      }),
    );

  }
}
