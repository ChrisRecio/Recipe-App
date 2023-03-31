//CREATE TABLE IF NOT EXISTS ShoppingList(id INTEGER NOT NULL PRIMARY KEY autoincrement, quantity TEXT, ingredientName TEXT, checked INTEGER);

import 'package:sqflite/sqflite.dart';

import '../models/shopping_list.dart';
import 'db_manager.dart';

class ShoppingListProvider {
  // Create ShoppingListItem
  static Future<int> createShoppingListItem(ShoppingListItem item) async {
    final db = await DbManager.db();

    final data = item.toMap();
    final id = await db.insert('ShoppingList', data, conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  // Get All Recipes
  static Future<List<Map<String, dynamic>>> getAllShoppingListItem() async {
    final db = await DbManager.db();
    return db.query('ShoppingList', orderBy: "id");
  }

  // Delete ShoppingListItem
  static Future<void> deleteShoppingListItem(int id) async {
    final db = await DbManager.db();
    await db.delete('ShoppingList', where: "id = ?", whereArgs: [id]);
  }

  // Update ShoppingListItem
  static Future<void> updateShoppingListItem(ShoppingListItem item) async {
    final db = await DbManager.db();
    final data = item.toMap();

    await db.update('ShoppingList', data, where: "id = ?", whereArgs: [item.id]);
  }
}
