import 'dart:ui';

// SQL
// CREATE TABLE IF NOT EXISTS Recipe(id INTEGER NOT NULL PRIMARY KEY autoincrement, recipe_name TEXT, image BLOB, servings INTEGER NOT NULL, description TEXT, course_id INTEGER NOT NULL, prep_time TIME, cook_time TIME, FOREIGN KEY(course_id) REFERENCES Course(id));
class Recipe {
  int _id;
  String _name;
  Image _image;
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

  Map<String, dynamic> toJson() {
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
}
