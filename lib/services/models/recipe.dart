// SQL
// CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, courseId INTEGER NOT NULL, prepTime TIME, prepTimeMeasurement TEXT, cookTime TIME, cookTimeMeasurement TEXT, FOREIGN KEY(courseId) REFERENCES Course(id));

class Recipe {
  int? _id;
  String _name;
  String? _image;
  int _servings;
  String _description;
  int _course;
  int _prepTime;
  String _prepTimeMeasurement;
  int _cookTime;
  String _cookTimeMeasurement;

  Recipe(this._id, this._name, this._image, this._servings, this._description, this._course, this._prepTime, this._prepTimeMeasurement,
      this._cookTime, this._cookTimeMeasurement);

  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(data['id'], data['name'], data['image'], data['servings'], data['description'], data['courseId'], data['prepTime'],
        data['prepTimeMeasurement'], data['cookTime'], data['cookTimeMeasurement']);
  }

  static List<Recipe> parseRecipeList(List<dynamic> list) {
    final recipeList = <Recipe>[];
    for (final item in list) {
      recipeList.add(Recipe.fromMap(item));
    }
    return recipeList;
  }

  Map<String, dynamic> toMap() {
    var map = {
      'id': _id,
      'name': _name,
      'image': _image,
      'servings': _servings,
      'description': _description,
      'courseId': _course,
      'prepTime': _prepTime,
      'prepTimeMeasurement': _prepTimeMeasurement,
      'cookTime': _cookTime,
      'cookTimeMeasurement': _cookTimeMeasurement
    };

    return map;
  }

  @override
  String toString() {
    return 'recipe{id: $_id, name: $_name, servings: $_servings, description:$_description, course_id: $_course, prepTime: $_prepTime, prepTimeMeasurement: $_prepTimeMeasurement, cookTime: $_cookTime, cookTimeMeasurement: $_cookTimeMeasurement,}';
  }

  int get cookTime => _cookTime;
  set cookTime(int value) => _cookTime = value;

  String get cookTimeMeasurement => _cookTimeMeasurement;
  set cookTimeMeasurement(String value) => _cookTimeMeasurement = value;

  int get prepTime => _prepTime;
  set prepTime(int value) => _prepTime = value;

  String get prepTimeMeasurement => _prepTimeMeasurement;
  set prepTimeMeasurement(String value) => _prepTimeMeasurement = value;

  int get course => _course;
  set course(int value) => _course = value;

  String get description => _description;
  set description(String value) => _description = value;

  int get servings => _servings;
  set servings(int value) => _servings = value;

  String? get image => _image;
  set image(String? value) => _image = value;

  String get name => _name;
  set name(String value) => _name = value;

  int? get id => _id;
  set id(int? value) => _id = value;
}
