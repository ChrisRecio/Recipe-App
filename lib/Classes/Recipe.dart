import 'package:flutter/material.dart';

class Recipe{

  int _id = 0;
  String _name = "";
  Image _image = Image.asset('assets/images/default.jpg');
  List _ingredients = [];
  List _steps = [];
  String _description = "";

  Recipe(this._id, this._name, this._image, this._ingredients, this._steps, this._description);

  int getId(){
    return _id;
  }

  String getName(){
    return _name;
  }

  Image getImage(){
    return _image;
  }

  List getIngredients(){
    return _ingredients;
  }

  List getSteps(){
    return _steps;
  }

  String getDescription() {
    return _description;
  }

  void setID(int id){
    _id = id;
  }

  void setName(String name){
    _name = name;
  }

  void setImage(Image image){
    _image = image;
  }

  void setIngredients(List ingredients){
    _ingredients = ingredients;
  }

  void setSteps(List steps){
    _steps = steps;
  }

  void setDescription(String description){
    _description = description;
  }

  Map<String,dynamic> get map {
    return {
      "Id": _id,
      "Name": _name,
      "Ingredients": _ingredients,
      "Steps": _steps,
      "Description": _description,
    };
  }
}