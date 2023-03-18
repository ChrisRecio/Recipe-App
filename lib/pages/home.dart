import 'package:flutter/material.dart';

import '../assets/constants.dart';
import '../services/functions/recipe_provider.dart';
import '../widgets/nav_drawer.dart';
import '../widgets/recipeGridView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Map<String, dynamic>> _recipeList = [];
  final int _numOfRecipesDisplayed = 5;

  bool _isLoading = true;
  void _refreshRecipeList() async {
    final data = await RecipeProvider.getNRecipes(_numOfRecipesDisplayed);
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
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text("PLACEHOLDER APP NAME"),
        centerTitle: true,
        backgroundColor: Constants.primaryRed,
      ),
      drawer: const NavDrawer(),
      body: Column(children: [
        featuredRecipe(),
        const SizedBox(
          height: 10,
        ),
        horizontalScrollRecipes(),
      ]),
    );
  }

  Widget featuredRecipe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 15,
            top: 10,
          ),
          child: Text(
            'Trending',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(10),
          color: Constants.secondaryRed,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: const Center(
                child: Text(
              'Recipe suggestion goes here',
              style: TextStyle(fontSize: 20),
            )),
          ),
        ),
      ],
    );
  }

  Widget horizontalScrollRecipes() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              'Your Recipes',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: _isLoading ? const Center(child: CircularProgressIndicator()) : recipeGridView(context, _recipeList, 1, Axis.horizontal, true),
          ),
        ],
      ),
    );
  }
}
