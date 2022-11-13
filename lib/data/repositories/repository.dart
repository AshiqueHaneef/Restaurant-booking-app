import 'package:restaurant_app/data/api/api.dart';
import 'package:restaurant_app/models/restaurant.dart';

class Repositories {
  static Future<RestaurantData?> fetchData() async {
    try {
      final data = await API.get();

      RestaurantData restaurantData =
          RestaurantData.fromMap(data.first as Map<String, dynamic>);
      return restaurantData;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
