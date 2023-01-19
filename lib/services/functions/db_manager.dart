import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// REFERENCE
//https://medium.flutterdevs.com/sql-database-storage-using-sqlite-in-flutter-6e2fdcc8cfb7

class DbManager {
  static Database? _db;
  final String _courseTable =
      "CREATE TABLE Course(id INTEGER NOT NULL PRIMARY KEY autoincrement, course_name TEXT);";
  final String _ingredientTable =
      "CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, ingredient_name TEXT NOT NULL, quantity TEXT NOT NULL);";
  final String _recipeTable =
      "CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, course_id INTEGER NOT NULL, prep_time TIME, cook_time TIME, FOREIGN KEY(course_id) REFERENCES Course(id));";
  final String _recipeStepTable =
      "CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_id INTEGER NOT NULL, step_number INTEGER NOT NULL, step_description TEXT, FOREIGN KEY(recipe_id) REFERENCES Recipe(id));";

  Future openDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'RecipeApp.db');

    // Delete the database
    await deleteDatabase(path);

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      Batch batch = db.batch();
      batch.execute(_courseTable);
      batch.execute(_ingredientTable);
      batch.execute(_recipeTable);
      batch.execute(_recipeStepTable);
      await batch.commit();
    });
    // Print table names upon creation
/*    var tableNames = (await _db
            ?.query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
        ?.map((row) => row['name'] as String)
        .toList(growable: false);
    print(tableNames);*/
    return _db;
  }

  Future close() async => _db?.close();
}
