import 'package:flutter/material.dart';

import '../assets/constants.dart';
import '../services/models/recipe.dart';
import '../widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Recipe>? recipeList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text("{PLACEHOLDER APP NAME}"),
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
