import 'dart:convert';

import 'package:http/http.dart' as http;

const mainUrl = "https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad";

class API {
  static Future<List> get() async {
    try {
      final response = await http.get(Uri.parse(mainUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print(e);
    }
    return Future.value([]);
  }
}
