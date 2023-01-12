import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:recipe_app/bloc/recipe.dart';
import 'package:sqflite/sqflite.dart';

void dbManager() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'recipe_app.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE recipes(id INTEGER PRIMARY KEY, name TEXT, image BLOB, ingredients BLOB, steps, BLOB, description TEXT)',
      );
    },
    version: 1,
  );

  // Get All Recipes
  Future<List<Recipe>> getAllRecipes() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('recipes');

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

  // Get Recipe By ID
  Future<Recipe> getRecipeById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('recipes');

    var result = await db.query("Recipes", where: "id = ", whereArgs: [id]);
    return Recipe.fromMap(result.first);
  }

  // Insert New Recipe
  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;

    await db.insert(
      'recipes',
      recipe.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update Recipe
  Future<void> updateRecipe(Recipe recipe) async {
    final db = await database;

    await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.getId()],
    );
  }
}
