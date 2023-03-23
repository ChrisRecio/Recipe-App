import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/pages/view_recipe_list.dart';

import '../assets/constants.dart';
import '../pages/view_recipe.dart';
import '../services/models/recipe.dart';

Widget recipeGridView(var context, var list, int crossAxisCount, var scrollDirection, bool viewMore) {
  return GridView.builder(
    scrollDirection: scrollDirection,
    padding: const EdgeInsets.all(10),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
    ),
    itemCount: viewMore ? list.length + 1 : list.length, // if true add view more button
    itemBuilder: (BuildContext ctx, index) {
      if (viewMore && (index == list.length)) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(color: Constants.secondaryRed, borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(5.0),
            child: const Center(
              child: Text(
                "See More",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ViewRecipeList(),
              ),
            ),
          },
        );
      } else {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(color: Constants.secondaryRed, borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: list[index]['image'] != null
                          ? Image.file(
                              File(list[index]['image']),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/logo.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Text(
                    list[index]['name'],
                    style: const TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewRecipe(recipe: Recipe.fromMap(list[index])),
              ),
            ),
          },
        );
      }
    },
  );
}
