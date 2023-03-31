// SQL
// CREATE TABLE IF NOT EXISTS Ingredient(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, ingredientName TEXT NOT NULL, FOREIGN KEY(recipeId) REFERENCES Recipe(id));

class Ingredient {
  int? _id;
  int _recipeId;
  String _ingredientName;

  Ingredient(this._id, this._recipeId, this._ingredientName);

  factory Ingredient.fromMap(Map<String, dynamic> data) {
    return Ingredient(data['id'], data['recipeId'], data['ingredientName']);
  }

  static List<Ingredient> parseIngredientList(List<dynamic> list) {
    final ingredientList = <Ingredient>[];
    for (final item in list) {
      ingredientList.add(Ingredient.fromMap(item));
    }
    return ingredientList;
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'recipeId': _recipeId, 'ingredientName': _ingredientName};
  }

  @override
  String toString() {
    return 'recipe{id: $_id, recipeId: $_recipeId, ingredientName: $_ingredientName}';
  }

  String get ingredientName => _ingredientName;
  set ingredientName(String value) => _ingredientName = value;

  int get recipeId => _recipeId;
  set recipeId(int value) => _recipeId = value;

  int? get id => _id;
  set id(int? value) => _id = value;
}
