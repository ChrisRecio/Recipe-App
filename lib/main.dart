import 'package:flutter/material.dart';
import 'package:recipe_app/bloc/recipe.dart';
import 'package:recipe_app/repository/db_manager.dart';
import 'package:recipe_app/screens/my_widgets/navigation_drawer.dart';

import 'screens/my_widgets/list_card.dart';

void main() {
  runApp(const MyApp());

  final DbManager dbManager = DbManager();
  Recipe grilledCheese = Recipe(
      0,
      "Grilled Cheese",
      "" /*Image.asset('assets/images/default.jpg')*/,
      1,
      ["Butter", "Bread", "Cheese"],
      [
        "Spread butter on the outside of the bread",
        "Place cheese between slices of bread",
        "Toast in frying pan until golden brown"
      ],
      "A toasted melted cheese sandwich");

  dbManager.insertRecipe(grilledCheese);
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
  final DbManager dbManager = DbManager();

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
                return ListCard(child: recipe.getName());
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
