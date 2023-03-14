import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/ingredient.dart';
import 'package:sqflite/sqflite.dart';

// SQL
// CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, ingredient_name TEXT NOT NULL);

class IngredientProvider {
  // Create Recipe
  static Future<int> createIngredient(Ingredient ingredient) async {
    final db = await DbManager.db();

    final data = ingredient.toMap();
    final id = await db.insert('Ingredient', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get all Ingredients by recipe id
  static Future<List<Map<String, dynamic>>> getAllIngredientByRecipeId(int id) async {
    final db = await DbManager.db();
    return db.query('Ingredient', where: "recipeId = ?", whereArgs: [id]);
  }

  // Get Ingredient by Id
  static Future<List<Map<String, dynamic>>> getIngredientById(int id) async {
    final db = await DbManager.db();
    return db.query('Ingredient', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update Ingredient
  static Future<int> updateIngredient(Ingredient ingredient) async {
    final db = await DbManager.db();
    final data = ingredient.toMap();

    final id = await db.update('Ingredient', data, where: "id = ?", whereArgs: [ingredient.id]);
    return id;
  }
}
