import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/assets/constants.dart';

class TrendingRecipeProvider {
  static Future<void> fetchRecipe() async {
    final response = await http.get(Uri.parse(Constants.apiURL));
    print(response);

    if (response.statusCode != 200) {
      throw Exception('Failed to get recipes');
    }
    print(jsonDecode(response.body));
    print("");
    // return Recipe.fromMap(jsonDecode(response.body));
  }
}
