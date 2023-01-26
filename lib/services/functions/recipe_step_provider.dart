import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/recipe_step.dart';
import 'package:sqflite/sqflite.dart';

// SQL
// CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_id INTEGER NOT NULL, step_number INTEGER NOT NULL, step_description TEXT, FOREIGN KEY(recipe_id) REFERENCES Recipe(id));

class RecipeStepProvider {
  // Create RecipeStep
  static Future<int> createRecipeStep(RecipeStep recipeStep) async {
    final db = await DbManager.db();

    final data = recipeStep.toMap();
    final id = await db.insert('RecipeStep', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get all RecipeSteps by recipe id
  static Future<List<Map<String, dynamic>>> getAllIngredientByRecipeId(int id) async {
    final db = await DbManager.db();
    return db.query('RecipeStep', where: "recipe_id = ?", whereArgs: [id]);
  }

  // Get RecipeStep by Id
  static Future<List<Map<String, dynamic>>> getIngredientById(int id) async {
    final db = await DbManager.db();
    return db.query('RecipeStep', where: "id = ?", whereArgs: [id], limit: 1);
  }
}
