import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/screens/add_recipe.dart';

class NavigationDrawer extends StatelessWidget{
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),


  );

  Widget buildHeader(BuildContext context) => Container();

  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    child: Wrap(
      runSpacing: 10,
      children: [ // ADD NEW NAV ITEMS AS A ListTile HERE
        ListTile(
          leading:  const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(title: 'Recipe List'))),
        ),
        ListTile(
          leading:  const Icon(Icons.local_pizza_outlined),
          title: const Text('Recipe List'),
          onTap: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomePage(title: 'Recipe List'))),
        ),
        ListTile(
          leading:  const Icon(Icons.plus_one_outlined),
          title: const Text('Add New Recipe'),
          onTap: () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AddRecipe())),
        ),

      ],
    ),
  );

}