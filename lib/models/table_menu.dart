import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/category_dish.dart';

class TableMenuList extends Equatable {
  TableMenuList({
    this.menuCategory,
    this.menuCategoryId,
    this.menuCategoryImage,
    this.nexturl,
    this.categoryDishes,
  });

  String? menuCategory;
  String? menuCategoryId;
  String? menuCategoryImage;
  String? nexturl;
  List<CategoryDish>? categoryDishes;

  factory TableMenuList.fromJson(String str) =>
      TableMenuList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TableMenuList.fromMap(Map<String, dynamic> json) => TableMenuList(
        menuCategory: json["menu_category"],
        menuCategoryId: json["menu_category_id"],
        menuCategoryImage: json["menu_category_image"],
        nexturl: json["nexturl"],
        categoryDishes: List<CategoryDish>.from(
            json["category_dishes"].map((x) => CategoryDish.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "menu_category": menuCategory,
        "menu_category_id": menuCategoryId,
        "menu_category_image": menuCategoryImage,
        "nexturl": nexturl,
        "category_dishes": List<Map<String, dynamic>>.from(
            categoryDishes!.map((x) => x.toMap())),
      };
  @override
  // TODO: implement props
  List<Object?> get props => [menuCategory];
}
