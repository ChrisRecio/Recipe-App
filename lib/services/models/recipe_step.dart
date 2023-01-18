// SQL
// CREATE TABLE IF NOT EXISTS RecipeStep(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_id INTEGER NOT NULL, step_number INTEGER NOT NULL, step_description TEXT, FOREIGN KEY(recipe_id) REFERENCES Recipe(id));
class RecipeStep {
  int _id;
  int _stepNumber;
  String _stepDescription;

  RecipeStep(this._id, this._stepNumber, this._stepDescription);

  factory RecipeStep.fromMap(Map<String, dynamic> data) {
    return RecipeStep(data['id'], data['stepNumber'], data['stepDescription']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'stepNumber': _stepNumber,
      'stepDescription': _stepDescription,
    };
  }

  @override
  String toString() {
    return 'recipe{id: $_id, stepNumber: $_stepNumber, stepDescription: $_stepDescription}';
  }
}
