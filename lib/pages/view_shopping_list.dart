import 'package:flutter/material.dart';

import '../assets/constants.dart';
import '../widgets/nav_drawer.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShoppingListState();
  }
}

class ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text('Shopping List'),
        centerTitle: true,
        backgroundColor: Constants.primaryRed,
      ),
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.secondaryRed,
        child: const Icon(Icons.add_sharp, size: 45),
        onPressed: () {
          print("here");
        },
      ),
      body: Container(),
    );
  }
}
