import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';

import '../../pages/view_recipe.dart';
import '../models/recipe.dart';

class RecipeListSearchDelegate extends SearchDelegate {
  List<Map<String, dynamic>> _searchTerms = [];

  void _refreshRecipeList() async {
    _searchTerms = await RecipeProvider.getAllRecipes();
  }
  // ^^^ returns [{name: 12}, {name: asd}, {name: gfd}]

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var recipeName in _searchTerms) {
      if (recipeName['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(recipeName);
      }
    }
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: matchQuery.length,
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
                    child: matchQuery[index]['image'] != null
                        ? Image.asset(
                            'assets/images/logo.jpg',
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
                    matchQuery[index]['name'],
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
                    builder: (context) => ViewRecipe(recipe: Recipe.fromMap(matchQuery[index])),
                  ))
            },
          );
        });
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> matchQuery = [];
    for (var recipeName in _searchTerms) {
      if (recipeName['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(recipeName);
      }
    }
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: matchQuery.length,
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
                    child: matchQuery[index]['image'] != null
                        ? Image.asset(
                            'assets/images/logo.jpg',
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
                    matchQuery[index]['name'],
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
                    builder: (context) => ViewRecipe(recipe: Recipe.fromMap(matchQuery[index])),
                  ))
            },
          );
        });
  }
}
