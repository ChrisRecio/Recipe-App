class ShoppingListItem {
  int? _id;
  String _quantity, _ingredientName;
  bool _checked;

  ShoppingListItem(this._id, this._quantity, this._ingredientName, this._checked);

  factory ShoppingListItem.fromMap(Map<String, dynamic> data) {
    return ShoppingListItem(data['_id'], data['_quantity'], data['_ingredientName'], data['_checked']);
  }

  static List<ShoppingListItem> parseShoppingListItem(List<dynamic> list) {
    final shoppingList = <ShoppingListItem>[];
    for (final item in list) {
      shoppingList.add(ShoppingListItem.fromMap(item));
    }
    return shoppingList;
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'quantity': _quantity, 'ingredientName': _ingredientName, 'checked': _checked};
  }

  @override
  String toString() {
    return 'ShoppingListItem{id: $_id, quantity: $_quantity ingredient: $_ingredientName, checked: $_checked}';
  }

  bool get checked => _checked;
  set checked(bool value) => _checked = value;

  String get quantity => _quantity;
  set quantity(String value) => _quantity = value;

  String get ingredient => _ingredientName;
  set Ingredient(String value) => _ingredientName = value;

  int? get id => _id;
  set id(int? value) => _id = value;
}
