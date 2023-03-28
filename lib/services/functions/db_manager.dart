import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DbManager {
  static const String _courseTable =
      "CREATE TABLE Course(id INTEGER NOT NULL PRIMARY KEY autoincrement, course_name TEXT);";
  static const String _ingredientTable =
      "CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, ingredientName TEXT NOT NULL, FOREIGN KEY(recipeId) REFERENCES Recipe(id));";
  static const String _recipeTable =
      "CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, courseId INTEGER NOT NULL, prepTime REAL, prepTimeMeasurement TEXT, cookTime REAL, cookTimeMeasurement TEXT, FOREIGN KEY(courseId) REFERENCES Course(id));";
  static const String _recipeStepTable =
      "CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, stepNumber INTEGER NOT NULL, stepDescription TEXT, FOREIGN KEY(recipeId) REFERENCES Recipe(id));";

  static Future<void> createTables(Database db) async {
    Batch batch = db.batch();
    batch.execute(_courseTable);
    batch.execute(_ingredientTable);
    batch.execute(_recipeTable);
    batch.execute(_recipeStepTable);
    await batch.commit();
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

  // Print table names upon creation
  static Future<void> printTables() async {
    final db = await DbManager.db();
    var tableNames = (await db
            .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        .map((row) => row['name'] as String)
        .toList(growable: false);
    print(tableNames);
  }
}
