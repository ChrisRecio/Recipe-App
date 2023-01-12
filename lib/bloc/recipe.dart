import 'package:flutter/material.dart';

class Recipe {
  int _id = 0;
  String _name = "";
  Image _image = Image.asset('assets/images/default.jpg');
  int _servings = 0;
  List<String> _ingredients = [];
  List<String> _steps = [];
  String _description = "";

  Recipe(this._id, this._name, this._image, this._servings, this._ingredients,
      this._steps, this._description);

  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(data['id'], data['name'], data['image'], data['servings'],
        data['ingredients'], data['steps'], data['description']);
  }

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  Image getImage() {
    return _image;
  }

  int getServings() {
    return _servings;
  }

  List getIngredients() {
    return _ingredients;
  }

  List getSteps() {
    return _steps;
  }

  String getDescription() {
    return _description;
  }

  void setID(int id) {
    _id = id;
  }

  void setName(String name) {
    _name = name;
  }

  void setImage(Image image) {
    _image = image;
  }

  void setServings(int servings) {
    _servings = servings;
  }

  void setIngredients(List<String> ingredients) {
    _ingredients = ingredients;
  }

  void setSteps(List<String> steps) {
    _steps = steps;
  }

  void setDescription(String description) {
    _description = description;
  }

  @override
  String toString() {
    return 'recipe{id: $_id, name: $_name, servings: $_servings, ingredients:$_ingredients, steps: $_steps, description: $_description}';
  }

  Map<String, dynamic> get map {
    return {
      "Id": _id,
      "Name": _name,
      "Servings": _servings,
      "Ingredients": _ingredients,
      "Steps": _steps,
      "Description": _description,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": _id,
      "Name": _name,
      "Servings": _servings,
      "Ingredients": _ingredients,
      "Steps": _steps,
      "Description": _description,
    };
  }
}
