import 'package:recipe_app/services/functions/ingredient_provider.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';
import 'package:recipe_app/services/functions/recipe_step_provider.dart';
import 'package:recipe_app/services/functions/shopping_list_provider.dart';
import 'package:recipe_app/services/models/ingredient.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:recipe_app/services/models/recipe_step.dart';
import 'package:recipe_app/services/models/shopping_list.dart';

class Seed {
  static Future<void> seedData() async {
    Recipe grilledCheese = Recipe(null, "Grilled Cheese", null, 1, "A grilled cheese sandwich", 1, 5, "minutes", 5, "minutes");
    int recipeId = await RecipeProvider.createRecipe(grilledCheese);

    Ingredient ingredient = Ingredient(null, recipeId, "Bread");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Cheese");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Butter");
    await IngredientProvider.createIngredient(ingredient);

    RecipeStep step = RecipeStep(null, recipeId, 1, "Spread butter on the outside of the bread");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 2, "Place cheese between both slices of bread");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 3, "Toast until golden brown");
    await RecipeStepProvider.createRecipeStep(step);

    Recipe pbj = Recipe(null, "Peanut butter jelly sandwich", null, 1, "A Peanut butter jelly sandwich", 1, 5, "minutes", 5, "minutes");
    recipeId = await RecipeProvider.createRecipe(pbj);

    ingredient = Ingredient(null, recipeId, "Bread");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Peanut Butter");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Jam");
    await IngredientProvider.createIngredient(ingredient);

    step = RecipeStep(null, recipeId, 1, "Spread peanut butter on one slice of bread");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 2, "Spread jam on the other slice of bread");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 3, "Combine both slices of bread");
    await RecipeStepProvider.createRecipeStep(step);

    Recipe hamAndCheese = Recipe(null, "Ham and cheese sandwich", null, 1, "A Ham and cheese sandwich", 1, 5, "minutes", 5, "minutes");
    recipeId = await RecipeProvider.createRecipe(hamAndCheese);

    ingredient = Ingredient(null, recipeId, "Bread");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Ham");
    await IngredientProvider.createIngredient(ingredient);
    ingredient = Ingredient(null, recipeId, "Cheese");
    await IngredientProvider.createIngredient(ingredient);

    step = RecipeStep(null, recipeId, 1, "Place ham on one slice of bread");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 2, "Place cheese on top of ham");
    await RecipeStepProvider.createRecipeStep(step);
    step = RecipeStep(null, recipeId, 3, "Place bread on top of cheese and serve");
    await RecipeStepProvider.createRecipeStep(step);
  }

  static Future<void> seedShoppingList() async {
    ShoppingListItem item = ShoppingListItem(null, "1", "Bread", false);
    ShoppingListProvider.createShoppingListItem(item);
    item = ShoppingListItem(null, "3", "Cheese", true);
    ShoppingListProvider.createShoppingListItem(item);
    item = ShoppingListItem(null, "12", "Apples", true);
    ShoppingListProvider.createShoppingListItem(item);
    item = ShoppingListItem(null, "2", "Jam", false);
    ShoppingListProvider.createShoppingListItem(item);
    item = ShoppingListItem(null, "4", "Ham", false);
    ShoppingListProvider.createShoppingListItem(item);
  }
}
