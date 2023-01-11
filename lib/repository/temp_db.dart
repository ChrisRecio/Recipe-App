import 'package:flutter/material.dart';
import '../bloc/recipe.dart';

recipe grilledCheese = recipe(0, "Grilled Cheese", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
recipe grilledCheese1 = recipe(1, "Grilled Cheese 1", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
recipe grilledCheese2 = recipe(2, "Grilled Cheese 2", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
recipe grilledCheese3 = recipe(3, "Grilled Cheese 3", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
recipe grilledCheese4 = recipe(4, "Grilled Cheese 4", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");



List foodList = [grilledCheese, grilledCheese1, grilledCheese2, grilledCheese3, grilledCheese4];

List getFoodList(){
  return foodList;
}

int getListLength(){
  return foodList.length;
}