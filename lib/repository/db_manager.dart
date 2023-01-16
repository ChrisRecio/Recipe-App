import 'dart:async';

import 'package:path/path.dart';
import 'package:recipe_app/bloc/recipe.dart';
import 'package:sqflite/sqflite.dart';

// REFERENCE
//https://medium.flutterdevs.com/sql-database-storage-using-sqlite-in-flutter-6e2fdcc8cfb7

class DbManager {
  late Database _database;

  Future openDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), "RecipeApp.db"),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE recipes(id INTEGER PRIMARY KEY autoincrement, name TEXT, image BLOB, ingredients BLOB, steps, BLOB, description TEXT)",
      );
    });
    return _database;
  }

  // Insert Recipe
  Future insertRecipe(Recipe recipe) async {
    await openDb();
    return await _database.insert('recipes', recipe.toJson());
  }

  // Get All Recipes
  Future<List<Recipe>> getRecipeList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.query('recipes');

    return List.generate(maps.length, (i) {
      return Recipe(
          maps[i]['id'],
          maps[i]['name'],
          maps[i]['image'],
          maps[i]['servings'],
          maps[i]['ingredients'],
          maps[i]['steps'],
          maps[i]['description']);
    });
  }

  // Get Recipe By Id
  Future<Recipe> getRecipeById(int idInput) async {
    await openDb();
    // PROBABLY BROKEN
    List<Map>? results =
        await _database.rawQuery('SELECT * FROM recipes WHERE id=?', [idInput]);
    Map<dynamic, dynamic> result = {};
    for (var r in results) {
      result.addAll(r);
    }
    return Recipe.fromMap(result[0]);
  }

  // Update Recipe
  Future<int> updateRecipe(Recipe recipe) async {
    await openDb();
    return await _database.update('recipes', recipe.toJson(),
        where: "id = ?", whereArgs: [recipe.getId()]);
  }

  // Delete Recipe
  Future<void> deleteRecipe(Recipe recipe) async {
    await openDb();
    await _database
        .delete('recipes', where: "id = ?", whereArgs: [recipe.getId()]);
  }
}
