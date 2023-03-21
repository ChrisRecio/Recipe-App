import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_app/assets/constants.dart';

import '../models/recipe.dart';

class TrendingRecipeProvider {
  static Future<Recipe> fetchRecipe() async {
    final response = await http.get(Uri.parse(Constants.apiURL));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Recipe.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
