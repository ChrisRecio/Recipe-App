// SQL
// CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_id INTEGER NOT NULL, step_number INTEGER NOT NULL, step_description TEXT, FOREIGN KEY(recipe_id) REFERENCES Recipe(id));
class RecipeStep {
  int? _id;
  int _recipeId;
  int _stepNumber;
  String _stepDescription;

  RecipeStep(this._id, this._recipeId, this._stepNumber, this._stepDescription);

  factory RecipeStep.fromMap(Map<String, dynamic> data) {
    return RecipeStep(data['id'], data['recipeId'], data['stepNumber'], data['stepDescription']);
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'recipeId': _recipeId, 'stepNumber': _stepNumber, 'stepDescription': _stepDescription};
  }

  @override
  String toString() {
    return 'recipe{id: $_id, recipeId: $_recipeId, stepNumber: $_stepNumber, stepDescription: $_stepDescription}';
  }

  String get stepDescription => _stepDescription;
  set stepDescription(String value) => _stepDescription = value;

  int get stepNumber => _stepNumber;
  set stepNumber(int value) => _stepNumber = value;

  int get recipeId => _recipeId;
  set recipeId(int value) => _recipeId = value;

  int? get id => _id;
  set id(int? value) => _id = value;
}
