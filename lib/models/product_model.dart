
import 'dart:ffi';

class ProductCategury {
  final String productId;
  final String categoryId;
  final String categoryName;
  final bool isSale;
  final String diliveryTime;
  final String updataAt;
  final String productDescription;
  final String createdAt;
  final String fullPrice;
  final List Images;
  final String salePrice ;

  ProductCategury({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.isSale,
    required this.diliveryTime,
    required this.updataAt,
    required this.productDescription,
    required this.createdAt,
    required this.fullPrice,
    required this.Images,
    required this.salePrice
  });
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'isSale': isSale,
      'diliveryTime': diliveryTime,
      'updataAt': updataAt,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'fullPrice': fullPrice,
      'Images': Images,
      'salePrice': salePrice
    };
  }

  factory ProductCategury.fromMap(Map<String, dynamic> map) {
    return ProductCategury(
          categoryId: map['categoryId'] ?? '',
          categoryName: map['categoryName'] ?? '',
          isSale: map['isSale'] ?? false,
          diliveryTime: map['diliveryTime'] ?? '',
          updataAt: map['updataAt'] ?? '',
          productDescription: map['productDescription'] ?? '',
          createdAt: map['createdAt'] ?? '',
          fullPrice: map['fullPrice'] ?? '',
          Images: map['Images'] ?? [],
          productId: map['productId'] ?? '' ,
          salePrice: map['salePrice'] ?? ''
         );
        }
}