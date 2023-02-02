import 'package:flutter/material.dart';
import 'package:recipe_app/pages/view_recipe.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';

import '../services/models/recipe.dart';
import '../widgets/navigation_drawer.dart';

class ViewRecipeList extends StatefulWidget {
  const ViewRecipeList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ViewRecipeListState();
  }
}

class ViewRecipeListState extends State<ViewRecipeList> {
  List<Map<String, dynamic>> _recipeList = [];

  bool _isLoading = true;
  void _refreshRecipeList() async {
    final data = await RecipeProvider.getAllRecipes();
    print(data);
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
        appBar: AppBar(title: const Text('Recipe List')),
        drawer: const NavigationDrawer(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _recipeList.length,
                itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(_recipeList[index]['name']),
                      subtitle: Text(_recipeList[index]['description']),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewRecipe(recipe: Recipe.fromMap(_recipeList[index])),
                            ))
                      },
                    ))));
  }
}
