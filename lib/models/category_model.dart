
class CategoryModel {
  final String categoryId;
  final String categoryImg;
  final String categoryName;
  final String createAt;
  final String updateAt;

  CategoryModel({
    required this.categoryId,
    required this.categoryImg,
    required this.categoryName,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImg': categoryImg,
      'categoryName': categoryName,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] ?? '',
      categoryImg: map['categoryImg'] ?? '',
      categoryName: map['categoryName'] ?? '',
      createAt: map['createAt'] ?? '',
      updateAt: map['updateAt'] ?? '',

    ) ;
  }
}