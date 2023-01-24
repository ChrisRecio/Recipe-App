import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

class RecipeProvider {
  // Create Recipe
  static Future<int> createRecipe(Recipe recipe) async {
    final db = await DbManager.db();

    final data = recipe.toMap();
    final id = await db.insert('Recipe', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get All Recipes
  static Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final db = await DbManager.db();
    return db.query('Recipe', orderBy: "id");
  }

  // Get Recipe by Id
  static Future<List<Map<String, dynamic>>> getRecipeById(int id) async {
    final db = await DbManager.db();
    return db.query('Recipe', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
