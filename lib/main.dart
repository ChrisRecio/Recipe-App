import 'package:flutter/material.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:recipe_app/widgets/nav_drawer.dart';

import '../assets/constants.dart';

void main() {
  runApp(const MyApp());
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
    // TEMPORARY DISPLAY UNTIL I DESIGN A HOMEPAGE UI
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Constants.primaryRed,
      ),
      drawer: const NavDrawer(),
      body: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Card(
                  color: Colors.white38,
                  child: SizedBox(
                    height: 100,
                    child: Center(child: Text('Temp')),
                  ),
                ),
                Card(
                  color: Colors.white38,
                  child: SizedBox(
                    height: 100,
                    child: Center(child: Text('Temp1')),
                  ),
                ),
                Card(
                  color: Colors.white38,
                  child: SizedBox(
                    height: 100,
                    child: Center(child: Text('Temp2')),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
