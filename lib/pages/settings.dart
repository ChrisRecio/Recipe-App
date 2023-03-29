import 'package:flutter/material.dart';

import '../assets/constants.dart';
import '../seed.dart';
import '../widgets/nav_drawer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Constants.primaryRed,
      ),
      drawer: const NavDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Constants.secondaryRed,
              child: const Text("Populate Recipe Data", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () => seedRecipeData(),
            ),
            MaterialButton(
              color: Constants.secondaryRed,
              child: const Text("Populate Shopping List Data", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () => seedShoppingListData(),
            )
          ],
        ),
      ),
    );
  }

  void seedRecipeData() async {
    await Seed.seedData();
  }

  void seedShoppingListData() async {
    await Seed.seedShoppingList();
  }
}
