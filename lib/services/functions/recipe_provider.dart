import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

class RecipeProvider {
  final Database _db = DbManager().openDb() as Database;

  Future<Recipe> insert(Recipe recipe) async {
    Map<String, dynamic> temp = recipe.toMap();
    recipe.id = await _db.insert('Recipe', recipe.toMap());
    return recipe;
  }
}
