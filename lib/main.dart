import 'package:flutter/material.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:recipe_app/widgets/navigation_drawer.dart';

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
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue.shade700,
      ),
      drawer: const NavigationDrawer(),
      body: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Card(
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(child: Text('Temp')),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
