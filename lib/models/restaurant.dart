// To parse this JSON data, do
//
//     final restaurantData = restaurantDataFromMap(jsonString);

import 'dart:convert';
import 'package:restaurant_app/models/table_menu.dart';
 
class RestaurantData {
  RestaurantData({
    this.restaurantId,
    this.restaurantName,
    this.restaurantImage,
    this.tableId,
    this.tableName,
    this.branchName,
    this.nexturl,
    this.tableMenuList,
  });

  String? restaurantId;
  String? restaurantName;
  String? restaurantImage;
  String? tableId;
  String? tableName;
  String? branchName;
  String? nexturl;
  List<TableMenuList>? tableMenuList;

  factory RestaurantData.fromJson(String str) =>
      RestaurantData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RestaurantData.fromMap(Map<String, dynamic> json) {
    try {
      return RestaurantData(
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        restaurantImage: json["restaurant_image"],
        tableId: json["table_id"],
        tableName: json["table_name"],
        branchName: json["branch_name"],
        nexturl: json["nexturl"],
        tableMenuList: List<TableMenuList>.from(
            json["table_menu_list"].map((x) => TableMenuList.fromMap(x))),
      );
    } catch (e, st) {
      print(e);
      print(st);
      throw Error();
    }
  }

  Map<String, dynamic> toMap() => {
        "restaurant_id": restaurantId,
        "restaurant_name": restaurantName,
        "restaurant_image": restaurantImage,
        "table_id": tableId,
        "table_name": tableName,
        "branch_name": branchName,
        "nexturl": nexturl,
        "table_menu_list":
            List<dynamic>.from(tableMenuList!.map((x) => x.toMap())),
      };
}

enum DishCurrency { SAR }

final dishCurrencyValues = EnumValues({"SAR": DishCurrency.SAR});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
