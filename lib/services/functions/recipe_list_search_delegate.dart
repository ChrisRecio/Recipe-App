import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';

import '../../assets/constants.dart';
import '../../pages/view_recipe.dart';
import '../models/recipe.dart';

class RecipeListSearchDelegate extends SearchDelegate {
  List<Map<String, dynamic>> rawSearchResults = [];
  List<String> searchResults = [];
  List<Map<String, dynamic>> recipesByName = [];

  void _refreshRecipeList() async {
    if (rawSearchResults.isEmpty) {
      rawSearchResults = await RecipeProvider.getAllRecipes();

      for (var element in rawSearchResults) {
        searchResults.add(element['name']);
      }
    }
  }

  Future<List<Map<String, dynamic>>> _searchRecipeByName(String name) async {
    final data = await RecipeProvider.searchRecipeByName(name);
    recipesByName = data;
    return recipesByName;
  }

  // right X button on search bar
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showResults(context);
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // left back arrow
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // query results
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Constants.beige,
      child: FutureBuilder(
        future: _searchRecipeByName(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: recipesByName.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: recipesByName[index]['image'] != null
                                ? Image.file(
                                    File(recipesByName[index]['image']),
                                    fit: BoxFit.cover,
                                    height: 140,
                                  )
                                : Image.asset(
                                    'assets/images/logo.jpg',
                                    fit: BoxFit.cover,
                                    height: 140,
                                  ),
                          ),
                          Text(
                            recipesByName[index]['name'],
                            style: const TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewRecipe(recipe: Recipe.fromMap(recipesByName[index])),
                          ))
                    },
                  );
                });
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Text("Loading...");
        },
      ),
    );
  }

  // query suggestions
  @override
  Widget buildSuggestions(BuildContext context) {
    _refreshRecipeList();
    List<String> suggestions = searchResults.where((i) => i.toLowerCase().contains(query.toLowerCase())).toList();

    return Container(
      color: Constants.beige,
      child: ListView.separated(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return Container(
            color: Constants.lightBeige,
            child: ListTile(
              title: Text(suggestion),
              onTap: () {
                query = suggestion;
                showResults(context);
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
      ),
    );
  }
}
