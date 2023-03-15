import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/recipe_step.dart';
import 'package:sqflite/sqflite.dart';

// SQL
// CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, stepNumber INTEGER NOT NULL, stepDescription TEXT, FOREIGN KEY(recipeId) REFERENCES Recipe(id));

class RecipeStepProvider {
  // Create RecipeStep
  static Future<int> createRecipeStep(RecipeStep recipeStep) async {
    final db = await DbManager.db();

    final data = recipeStep.toMap();
    final id = await db.insert('RecipeStep', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get all RecipeSteps by recipe id
  static Future<List<Map<String, dynamic>>> getAllRecipeStepsByRecipeId(int id) async {
    final db = await DbManager.db();
    return db.query('RecipeStep', where: "recipeId = ?", orderBy: "stepNumber ASC", whereArgs: [id]);
  }

  // Get RecipeStep by Id
  static Future<List<Map<String, dynamic>>> getRecipeStepById(int id) async {
    final db = await DbManager.db();
    return db.query('RecipeStep', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update RecipeStep
  static Future<void> updateRecipeStep(RecipeStep recipeStep) async {
    final db = await DbManager.db();
    final data = recipeStep.toMap();

    await db.update('RecipeStep', data, where: "id = ?", whereArgs: [recipeStep.id]);
  }

  // Delete RecipeStep
  static Future<void> deleteRecipeStep(int id) async {
    final db = await DbManager.db();
    await db.delete('RecipeStep', where: "id = ?", whereArgs: [id]);
  }
}
