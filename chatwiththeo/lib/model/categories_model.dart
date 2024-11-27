import 'base_response.dart';

class CategoryModel {
  int? categoryID;
  String? categoryName;
  int? gameID;
  bool? isActive;
  String? imagePath;
  String? bGColor1;
  String? bGColor2;
  int? order;
  String? description;

  CategoryModel(
      {this.categoryID,
      this.categoryName,
      this.gameID,
      this.isActive,
      this.imagePath,
      this.bGColor1,
      this.bGColor2,
      this.order,
      this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryID = json['CategoryID'];
    categoryName = json['CategoryName'];
    gameID = json['GameID'];
    isActive = json['IsActive'];
    imagePath = json['ImagePath'];
    bGColor1 = json['BGColor1'];
    bGColor2 = json['BGColor2'];
    order = json['Order'];
    description = json['Description'];
  }

  static ResponseBase<List<CategoryModel>> getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <CategoryModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(CategoryModel.fromJson(v));
        });
      }
      return ResponseBase<List<CategoryModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
