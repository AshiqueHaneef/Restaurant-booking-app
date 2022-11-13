import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/restaurant.dart';

import 'add_on.dart';

class CategoryDish extends Equatable {
  CategoryDish(
      {this.dishId,
      this.dishName,
      this.dishPrice,
      this.dishImage,
      this.dishCurrency,
      this.dishCalories,
      this.dishDescription,
      this.dishAvailability,
      this.dishType,
      this.nexturl,
      this.addonCat,
      this.qty = 0});

  String? dishId;
  String? dishName;
  double? dishPrice;
  String? dishImage;
  DishCurrency? dishCurrency;
  double? dishCalories;
  String? dishDescription;
  bool? dishAvailability;
  int? dishType;
  String? nexturl;
  List<AddonCat>? addonCat;
  int qty;

  factory CategoryDish.fromJson(String str) =>
      CategoryDish.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryDish.fromMap(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"],
        dishName: json["dish_name"],
        dishPrice:
            json["dish_price"] == null ? 0 : json["dish_price"].toDouble(),
        dishImage: json["dish_image"],
        dishCurrency: dishCurrencyValues.map[json["dish_currency"]],
        dishCalories: json["dish_calories"].toDouble() ?? 0,
        dishDescription: json["dish_description"],
        dishAvailability: json["dish_Availability"],
        dishType: json["dish_Type"],
        nexturl: json["nexturl"],
        addonCat: json["addonCat"] == null
            ? null
            : List<AddonCat>.from(
                json["addonCat"].map((x) => AddonCat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "dish_id": dishId,
        "dish_name": dishName,
        "dish_price": dishPrice,
        "dish_image": dishImage,
        "dish_currency": dishCurrencyValues.reverse[dishCurrency],
        "dish_calories": dishCalories,
        "dish_description": dishDescription,
        "dish_Availability": dishAvailability,
        "dish_Type": dishType,
        "nexturl": nexturl == null ? null : nexturl,
        "addonCat": addonCat == null
            ? null
            : List<dynamic>.from(addonCat!.map((x) => x.toMap())),
      };

  double get itemTotal => ((dishPrice ?? 0) * qty);

  @override
  // TODO: implement props
  List<Object?> get props => [dishId];
}
