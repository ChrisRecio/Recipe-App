import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:sqflite/sqflite.dart';

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
}
