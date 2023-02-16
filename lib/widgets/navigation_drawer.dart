import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/pages/add_recipe.dart';
import 'package:recipe_app/pages/view_recipe_list.dart';

import '../pages/settings.dart';

class NavigationDrawer extends StatelessWidget {
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

  Widget buildHeader(BuildContext context) => DrawerHeader(
      decoration: const BoxDecoration(color: Colors.redAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.asset('assets/images/logo.jpg'),
              ),
            ),
          ),
          const Center(
            child: Text(
              "PLACEHOLDER APP NAME",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ));

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 10,
          children: [
            // ADD NEW NAV ITEMS AS A ListTile HERE
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(title: 'Recipe List'))),
            ),
            ListTile(
              leading: const Icon(Icons.local_pizza_outlined),
              title: const Text('Recipe List'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ViewRecipeList())),
            ),
            ListTile(
              leading: const Icon(Icons.plus_one_outlined),
              title: const Text('Add New Recipe'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AddRecipe())),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Settings())),
            ),
          ],
        ),
      );
}
