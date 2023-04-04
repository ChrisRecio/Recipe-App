import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/shopping_list_provider.dart';
import 'package:recipe_app/services/models/shopping_list.dart';

import '../assets/constants.dart';
import '../widgets/nav_drawer.dart';

enum MenuItem {
  reset,
  share,
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({super.key});

  @override
  State<StatefulWidget> createState() {
    return ShoppingListState();
  }
}

class ShoppingListState extends State<ShoppingList> {
  List<Map<String, dynamic>> _shoppingListDb = [];
  List<ShoppingListItem> _shoppingList = [];
  final _formKey = GlobalKey<FormState>();
  late String _quantity, _itemName;

  void _refreshShoppingList() async {
    final data = await ShoppingListProvider.getAllShoppingListItem();
    if (!mounted) return;
    setState(
      () {
        _shoppingListDb = data;
      },
    );
    _shoppingList = [];
    for (int i = 0; i < _shoppingListDb.length; i++) {
      _shoppingList.add(ShoppingListItem(
          _shoppingListDb[i]['id'],
          _shoppingListDb[i]['quantity'],
          _shoppingListDb[i]['ingredientName'],
          _shoppingListDb[i]['checked'] == 1 ? true : false));
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    _refreshShoppingList();
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text('Shopping List'),
        centerTitle: true,
        backgroundColor: Constants.primaryRed,
        actions: [
          _popupMenu(),
        ],
      ),
      drawer: const NavDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.secondaryRed,
        child: const Icon(Icons.add_sharp, size: 45),
        onPressed: () {
          print("here");
          addItemForm(context);
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
                  _shoppingList[index].quantity,
                  _shoppingList[index].ingredientName,
                  _shoppingList[index].checked == true ? 1 : 0,
                  index,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  addItemForm(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    icon: Icon(Icons.numbers),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the quantity';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _quantity = value!),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.fastfood),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the ingredient';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _itemName = value!),
                ),
                MaterialButton(
                  color: Constants.green,
                  child: Text("Submit",
                      style: TextStyle(
                          color: Constants.white, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    final isValid = _formKey.currentState?.validate();

                    if (isValid == true) {
                      _formKey.currentState?.save();
                    }

                    ShoppingListItem item =
                        ShoppingListItem(null, _quantity, _itemName, false);
                    ShoppingListProvider.createShoppingListItem(item);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget ingredientItem(
      int id, String quantity, String ingredient, int checked, int index) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        setState(
          () {
            _shoppingList.removeAt(index);
            ShoppingListProvider.deleteShoppingListItem(id);
            _refreshShoppingList();

            final message = '$ingredient removed';
            final snackBar = SnackBar(
              content: Text(
                message,
                style: const TextStyle(fontSize: 20),
              ),
              backgroundColor: Constants.primaryRed,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
      },
      background: Container(color: Constants.primaryRed),
      child: ListTile(
        title: Text(
          ingredient,
          style: checked == 1
              ? const TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.lineThrough)
              : const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
        ),
        trailing: checked == 1
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
              // Convert 1/0 to T/F
              // bool check = _shoppingList[index].checked == 1 ? true : false;

              // Update item in db
              ShoppingListItem item = ShoppingListItem(
                  _shoppingList[index].id,
                  _shoppingList[index].quantity,
                  _shoppingList[index].ingredientName,
                  !_shoppingList[index].checked);
              ShoppingListProvider.updateShoppingListItem(item);
            },
          );
        },
      ),
    );
  }

  Widget _popupMenu() {
    return PopupMenuButton<MenuItem>(
      onSelected: (value) {
        if (value == MenuItem.share) {
        } else if (value == MenuItem.reset) {
          showAlertDialog(context);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: MenuItem.share,
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
        ),
        const PopupMenuItem(
          value: MenuItem.reset,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Reset List'),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Confirm"),
      onPressed: () {
        resetShoppingList();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Reset Shopping List"),
      content: const Text("Are you sure you want to reset the shopping list?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  resetShoppingList() async {
    await ShoppingListProvider.deleteAllShoppingListItems();
  }
}
