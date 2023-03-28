import 'package:flutter/material.dart';
import 'package:recipe_app/services/models/shopping_list.dart';

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
  // List<Map<String, dynamic>> _shoppingList = [];
  final List<ShoppingListItem> _shoppingList = [
    ShoppingListItem(1, "Cheese", false),
    ShoppingListItem(2, "Bread", true),
    ShoppingListItem(3, "Peanut Butter", false),
    ShoppingListItem(4, "Jam", false),
    ShoppingListItem(5, "Butter", false),
    ShoppingListItem(6, "Cheese", false),
    ShoppingListItem(7, "Bread", false),
    ShoppingListItem(8, "Peanut Butter", false),
    ShoppingListItem(9, "Jam", false),
    ShoppingListItem(10, "Butter", false),
  ];

  List<ShoppingListItem> _selectedIngredients = [];

  bool _isLoading = true;
  void _refreshShoppingList() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshShoppingList();
  }

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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _shoppingList.length,
              itemBuilder: (context, index) {
                return ingredientItem(
                  _shoppingList[index].id!,
                  _shoppingList[index].ingredient,
                  _shoppingList[index].checked,
                  index,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          _selectedIngredients.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.green[700],
                      child: Text(
                        "Delete (${_selectedIngredients.length})",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        print("Delete List Lenght: ${_selectedIngredients.length}");
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget ingredientItem(int id, String ingredient, bool checked, int index) {
    return ListTile(
      title: Text(
        ingredient,
        style: checked
            ? const TextStyle(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough)
            : const TextStyle(
                fontWeight: FontWeight.w500,
              ),
      ),
      trailing: checked
          ? Icon(
              Icons.check_circle,
              color: Constants.green,
            )
          : const Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(
          () {
            _shoppingList[index].checked = !_shoppingList[index].checked;
            if (_shoppingList[index].checked == true) {
              _selectedIngredients.add(ShoppingListItem(id, ingredient, true));
            } else if (_shoppingList[index].checked == false) {
              _selectedIngredients.removeWhere((element) => element.ingredient == _shoppingList[index].ingredient);
            }
          },
        );
      },
    );
  }
}
