import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';

import '../assets/constants.dart';
import '../services/functions/recipe_list_search_delegate.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/recipe_grid_view.dart';

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
    _refreshRecipeList();
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
          title: const Text('Recipe List'),
          backgroundColor: Constants.primaryRed,
          centerTitle: true,
          actions: [
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
          : Scrollbar(
              child: recipeGridView(
                  context, _recipeList, 2, Axis.vertical, false)),
    );
  }
}
