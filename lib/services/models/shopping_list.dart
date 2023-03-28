class ShoppingListItem {
  int? _id;
  String _ingredientName;
  bool _checked;

  ShoppingListItem(this._id, this._ingredientName, this._checked);

  factory ShoppingListItem.fromMap(Map<String, dynamic> data) {
    return ShoppingListItem(
        data['id'], data['_ingredientName'], data['_checked']);
  }

  static List<ShoppingListItem> parseShoppingListItem(List<dynamic> list) {
    final shoppingList = <ShoppingListItem>[];
    for (final item in list) {
      shoppingList.add(ShoppingListItem.fromMap(item));
    }
    return shoppingList;
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'ingredient': _ingredientName, 'checked': _checked};
  }

  @override
  String toString() {
    return 'ShoppingListItem{id: $_id, ingredient: $_ingredientName, checked: $_checked}';
  }

  bool get checked => _checked;
  set checked(bool value) => _checked = value;

  String get ingredient => _ingredientName;
  set Ingredient(String value) => _ingredientName = value;

  int? get id => _id;
  set id(int? value) => _id = value;
}
