import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/db_manager.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:recipe_app/widgets/list_card.dart';
import 'package:recipe_app/widgets/navigation_drawer.dart';

void main() {
  runApp(const MyApp());
  DbManager db = DbManager();
  db.openDb();

  Recipe recipe = Recipe(
      1, "_name", "_image", 1, "_description", 1, "_prepTime", "_cookTime");
  RecipeProvider rp = RecipeProvider();
  rp.insert(recipe);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'Recipe List'),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  Recipe? recipe;
  List<Recipe>? recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.shade700,
      ),
      drawer: const NavigationDrawer(),
      body: FutureBuilder(builder: (context, snapshot) {
        if (snapshot.hasData) {
          recipeList = (snapshot.data as List<Recipe>);
          return ListView.builder(
              itemCount: recipeList?.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipeList![index];
                return const ListCard(child: "Recipe");
              });
        } else {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return const ListCard(child: "Recipe");
              });
        }
      }),
    );
  }
}
