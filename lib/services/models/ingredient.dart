// SQL
// CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, ingredient_name TEXT NOT NULL, quantity TEXT NOT NULL);

class Ingredient {
  int _id;
  String _ingredientName;
  String _quantity;

  Ingredient(this._id, this._ingredientName, this._quantity);

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(data['id'], data['ingredientName'], data['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'ingredientName': _ingredientName,
      'quantity': _quantity,
    };
  }

  @override
  String toString() {
    return 'recipe{id: $_id, ingredientName: $_ingredientName, quantity: $_quantity}';
  }
}
