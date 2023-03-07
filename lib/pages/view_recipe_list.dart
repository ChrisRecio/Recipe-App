import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/pages/view_recipe.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';

import '../assets/constants.dart';
import '../services/functions/recipe_list_search_delegate.dart';
import '../services/models/recipe.dart';
import '../widgets/nav_drawer.dart';

class ViewRecipeList extends StatefulWidget {
  const ViewRecipeList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ViewRecipeListState();
  }
}

class ViewRecipeListState extends State<ViewRecipeList> {
  List<Map<String, dynamic>> _recipeList = [];
  List<Map<String, dynamic>> _searchTerms = [];

  bool _isLoading = true;
  void _refreshRecipeList() async {
    final data = await RecipeProvider.getAllRecipes();
    _searchTerms = await RecipeProvider.getAllRecipeNames();
    setState(() {
      _recipeList = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshRecipeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe List'), backgroundColor: Constants.lightRedColor, centerTitle: true, actions: [
        IconButton(
          onPressed: () {
            // print(_searchTerms);
            showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: RecipeListSearchDelegate());
          },
          icon: const Icon(Icons.search),
        )
      ]),
      drawer: const NavDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: _recipeList.length,
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
                          child: _recipeList[index]['image'] != null
                              ? Image.file(
                                  File(_recipeList[index]['image']),
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
                          _recipeList[index]['name'],
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
                          builder: (context) => ViewRecipe(recipe: Recipe.fromMap(_recipeList[index])),
                        ))
                  },
                );
              }),
    );
  }
}
