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
      body: Column(
        children: [
          featuredRecipe(),
          const SizedBox(
            height: 10,
          ),
          horizontalScrollRecipes(),
        ],
      ),
    );
  }

  Widget featuredRecipe() {
    List<Widget> children = [recipeCard(), recipeCard(), recipeCard()];

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
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Container(
            color: Constants.beige,
            margin: const EdgeInsets.all(10),
            // TODO
            // IMPLEMENT THIS PACKAGE
            // https://pub.dev/packages/smooth_page_indicator
            child: Scrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(), // this for snapping
                itemCount: children.length,
                itemBuilder: (_, index) => children[index],
              ),
            ),
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Scrollbar(child: recipeGridView(context, _recipeList, 1, Axis.horizontal, true)),
          ),
        ],
      ),
    );
  }

  Widget recipeCard() => SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: Card(
          shadowColor: Constants.darkBeige,
          margin: const EdgeInsets.all(10),
          color: Constants.secondaryRed,
          child: const Center(
            child: Text(
              'Recipe suggestion goes here',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
