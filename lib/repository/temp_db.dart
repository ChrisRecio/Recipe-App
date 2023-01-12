import 'package:flutter/material.dart';

import '../bloc/recipe.dart';

Recipe grilledCheese = Recipe(
    0,
    "Grilled Cheese",
    Image.asset('assets/images/default.jpg'),
    1,
    ["Butter", "Bread", "Cheese"],
    [
      "Spread butter on the outside of the bread",
      "Place cheese between slices of bread",
      "Toast in frying pan until golden brown"
    ],
    "A toasted melted cheese sandwich");
Recipe grilledCheese1 = Recipe(
    1,
    "Grilled Cheese 1",
    Image.asset('assets/images/default.jpg'),
    1,
    ["Butter", "Bread", "Cheese"],
    [
      "Spread butter on the outside of the bread",
      "Place cheese between slices of bread",
      "Toast in frying pan until golden brown"
    ],
    "A toasted melted cheese sandwich");
Recipe grilledCheese2 = Recipe(
    2,
    "Grilled Cheese 2",
    Image.asset('assets/images/default.jpg'),
    1,
    ["Butter", "Bread", "Cheese"],
    [
      "Spread butter on the outside of the bread",
      "Place cheese between slices of bread",
      "Toast in frying pan until golden brown"
    ],
    "A toasted melted cheese sandwich");
Recipe grilledCheese3 = Recipe(
    3,
    "Grilled Cheese 3",
    Image.asset('assets/images/default.jpg'),
    1,
    ["Butter", "Bread", "Cheese"],
    [
      "Spread butter on the outside of the bread",
      "Place cheese between slices of bread",
      "Toast in frying pan until golden brown"
    ],
    "A toasted melted cheese sandwich");
Recipe grilledCheese4 = Recipe(
    4,
    "Grilled Cheese 4",
    Image.asset('assets/images/default.jpg'),
    1,
    ["Butter", "Bread", "Cheese"],
    [
      "Spread butter on the outside of the bread",
      "Place cheese between slices of bread",
      "Toast in frying pan until golden brown"
    ],
    "A toasted melted cheese sandwich");

List foodList = [
  grilledCheese,
  grilledCheese1,
  grilledCheese2,
  grilledCheese3,
  grilledCheese4
];

List getFoodList() {
  return foodList;
}

int getListLength() {
  return foodList.length;
}
