import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../models/recipe.dart';

// REFERENCE
//https://medium.flutterdevs.com/sql-database-storage-using-sqlite-in-flutter-6e2fdcc8cfb7
//https://www.kindacode.com/article/flutter-sqlite/

class DbManager {
  static const String _courseTable =
      "CREATE TABLE Course(id INTEGER NOT NULL PRIMARY KEY autoincrement, course_name TEXT);";
  static const String _ingredientTable =
      "CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, ingredient_name TEXT NOT NULL, quantity TEXT NOT NULL);";
  static const String _recipeTable =
      "CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, courseId INTEGER NOT NULL, prepTime TIME, cookTime TIME, FOREIGN KEY(courseId) REFERENCES Course(id));";
  static const String _recipeStepTable =
      "CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_id INTEGER NOT NULL, step_number INTEGER NOT NULL, step_description TEXT, FOREIGN KEY(recipe_id) REFERENCES Recipe(id));";

  static Future<void> createTables(Database db) async {
    Batch batch = db.batch();
    batch.execute(_courseTable);
    batch.execute(_ingredientTable);
    batch.execute(_recipeTable);
    batch.execute(_recipeStepTable);
    await batch.commit();
    // Print table names upon creation
/*    var tableNames = (await db
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);
    print(tableNames);*/
  }

  static Future<Database> db() async {
    return openDatabase(
      'Recipe.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

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
