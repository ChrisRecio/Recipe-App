import 'package:flutter/material.dart';
import 'Classes/Recipe.dart';

Recipe grilledCheese = Recipe(0, "Grilled Cheese", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
Recipe grilledCheese1 = Recipe(1, "Grilled Cheese 1", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");
Recipe grilledCheese2 = Recipe(0, "Grilled Cheese 2", Image.asset('assets/images/default.jpg'), ["Butter", "Bread", "Cheese"], ["Spread butter on the outside of the bread", "Place cheese between slices of bread", "Toast in frying pan until golden brown"], "A toasted melted cheese sandwich");

List foodList = [grilledCheese, grilledCheese1, grilledCheese2];

List getFoodList(){
  return foodList;
}