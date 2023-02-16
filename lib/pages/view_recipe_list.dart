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
      appBar: AppBar(title: const Text('Recipe List'), actions: [
        IconButton(
          onPressed: () {
            // method to show the search bar
/*              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: );*/

            print("Search Button");
          },
          icon: const Icon(Icons.search),
        )
      ]),
      drawer: const NavigationDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: _recipeList.length,
              itemBuilder: (BuildContext ctx, index) {
                return ListTile(
                  title: Text(_recipeList[index]['name']),
                  subtitle: Text(_recipeList[index]['description']),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewRecipe(recipe: Recipe.fromMap(_recipeList[index])),
                        ))
                  },
                );
              }),

      /*ListView.builder(
                itemCount: _recipeList.length,
                itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => {},
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) => {},
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),
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
                      ),
                    )
                )
        )*/
    );
  }
}
