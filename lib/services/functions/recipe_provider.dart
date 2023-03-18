import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/functions/recipe_step_provider.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

import 'ingredient_provider.dart';

// SQL
// CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, courseId INTEGER NOT NULL, prepTime TIME, prepTimeMeasurement TEXT, cookTime TIME, cookTimeMeasurement TEXT, FOREIGN KEY(courseId) REFERENCES Course(id));

class RecipeProvider {
  // Create Recipe
  static Future<int> createRecipe(Recipe recipe) async {
    final db = await DbManager.db();

    final data = recipe.toMap();
    final id = await db.insert('Recipe', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get All Recipes
  static Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final db = await DbManager.db();
    return db.query('Recipe', orderBy: "id");
  }

  // Get All Recipe Names
  static Future<List<Map<String, Object?>>> getAllRecipeNames() async {
    final db = await DbManager.db();
    return db.rawQuery("SELECT name FROM Recipe");
  }

  // Get n Recipes
  static Future<List<Map<String, Object?>>> getNRecipes(int n) async {
    final db = await DbManager.db();
    return db.rawQuery("SELECT * FROM Recipe LIMIT $n");
  }

  // Get Recipe by Id
  static Future<List<Map<String, dynamic>>> getRecipeById(int id) async {
    final db = await DbManager.db();
    return db.query('Recipe', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Search Recipes by name
  static Future<List<Map<String, dynamic>>> searchRecipeByName(String name) async {
    final db = await DbManager.db();
    return db.query('Recipe', where: "name LIKE ?", whereArgs: ['%$name%']);
  }

  // Update Recipe
  static Future<void> updateRecipe(Recipe recipe) async {
    final db = await DbManager.db();
    final data = recipe.toMap();

    await db.update('Recipe', data, where: "id = ?", whereArgs: [recipe.id]);
  }

  // Delete Recipe
  static Future<void> deleteRecipe(int recipeId) async {
    final db = await DbManager.db();
    await db.delete('Recipe', where: "id = ?", whereArgs: [recipeId]);

    final ingredientData = await IngredientProvider.getAllIngredientByRecipeId(recipeId);
    final stepData = await RecipeStepProvider.getAllRecipeStepsByRecipeId(recipeId);

    for (int i = 0; i < ingredientData.length; i++) {
      await IngredientProvider.deleteIngredient(ingredientData[i]['id']);
    }

    for (int i = 0; i < stepData.length; i++) {
      await RecipeStepProvider.deleteRecipeStep(stepData[i]['id']);
    }
  }
}
