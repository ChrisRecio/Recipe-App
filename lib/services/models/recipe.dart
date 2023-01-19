// SQL
// CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, course_id INTEGER NOT NULL, prep_time TIME, cook_time TIME, FOREIGN KEY(course_id) REFERENCES Course(id));
class Recipe {
  int _id;
  String _name;
  String _image;
  int _servings;
  String _description;
  int _course;
  String _prepTime;
  String _cookTime;

  Recipe(this._id, this._name, this._image, this._servings, this._description,
      this._course, this._prepTime, this._cookTime);

  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
        data['id'],
        data['name'],
        data['image'],
        data['servings'],
        data['description'],
        data['course'],
        data['prepTime'],
        data['cookTime']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'image': _image,
      'servings': _servings,
      'description': _description,
      'course': _course,
      'prepTime': _prepTime,
      'cookTime': _cookTime,
    };
  }

  @override
  String toString() {
    return 'recipe{id: $_id, name: $_name, servings: $_servings, description:$_description, course: $_course, prepTime: $_prepTime, cookTime: $_cookTime}';
  }

  String get cookTime => _cookTime;
  set cookTime(String value) => _cookTime = value;

  String get prepTime => _prepTime;
  set prepTime(String value) => _prepTime = value;

  int get course => _course;
  set course(int value) => _course = value;

  String get description => _description;
  set description(String value) => _description = value;

  int get servings => _servings;
  set servings(int value) => _servings = value;

  String get image => _image;
  set image(String value) => _image = value;

  String get name => _name;
  set name(String value) => _name = value;

  int get id => _id;
  set id(int value) => _id = value;
}
