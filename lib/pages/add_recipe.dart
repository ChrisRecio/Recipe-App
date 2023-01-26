import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/services/functions/ingredient_provider.dart';
import 'package:recipe_app/services/functions/recipe_provider.dart';
import 'package:recipe_app/services/functions/recipe_step_provider.dart';
import 'package:recipe_app/services/models/ingredient.dart';
import 'package:recipe_app/services/models/recipe.dart';
import 'package:recipe_app/services/models/recipe_step.dart';

import '../widgets/navigation_drawer.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  late String _name;
  File? image;
  late int _servings;
  late String _description;
  late int _course;
  late int _prepTime;
  late int _cookTime;
  late String _prepTimeMeasurement;
  late String _cookTimeMeasurement;
  late List<String> _ingredients;
  late List<String> _steps;
  static const List<String> timeDuration = <String>['Minutes', 'Hours'];
  String dropdownValue = timeDuration.first;

  final formKey = GlobalKey<FormState>();
  final LineSplitter ls = const LineSplitter();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e'); // REMOVE BEFORE PROD
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e'); // REMOVE BEFORE PROD
    }
  }

  Widget _buildImageField() {
    return Column(
      children: [
        MaterialButton(
            color: Colors.blue,
            child: const Text("Pick Image from Gallery", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImage();
            }),
        MaterialButton(
            color: Colors.blue,
            child: const Text("Pick Image from Camera", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImageC();
            }),
        const SizedBox(
          height: 20,
        ),
        image != null ? Image.file(image!) : const Text("No image selected")
      ],
    );
  }

  Widget _buildNameField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the name of the recipe';
          }
          return null;
        },
        onSaved: (value) => setState(() => _name = value!),
      );

  Widget _buildServingsField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Servings',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) <= 0) {
            return 'Servings must be greater or equal to 1';
          }
          return null;
        },
        onSaved: (value) => setState(() => _servings = int.parse(value!)),
      );

  Widget _buildIngredientsField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Ingredients',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter at least 1 ingredient';
          }
          return null;
        },
        onSaved: (value) => setState(() {
          _ingredients = ls.convert(value!);
        }),
      );

  Widget _buildStepsField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Steps',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter at least 1 step';
          }
          return null;
        },
        onSaved: (value) => setState(() {
          _steps = ls.convert(value!);
        }),
      );

  Widget _buildDescriptionField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: (value) => setState(() => _description = value!),
      );

  Widget _buildPrepTimeField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Prep Time',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) <= 0) {
            return 'Prep Time must be longer than 0 minutes';
          }
          return null;
        },
        onSaved: (value) => setState(() => _prepTime = int.parse(value!)),
      );

  Widget _buildCookTimeField() => TextFormField(
        decoration: const InputDecoration(
          labelText: 'Cook Time',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) <= 0) {
            return 'Cook Time must be longer than 0 minutes';
          }
          return null;
        },
        onSaved: (value) => setState(() => _cookTime = int.parse(value!)),
      );

  Widget _buildPrepTimeDropDown() => DropdownButton<String>(
        value: timeDuration.first,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: timeDuration.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  Widget _buildCookTimeDropDown() => DropdownButton<String>(
        value: timeDuration.first,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: timeDuration.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      drawer: const NavigationDrawer(),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ------------------------------------------------ NEED TO DESIGN UI
                _buildImageField(),
                const SizedBox(height: 16),
                _buildNameField(),
                const SizedBox(height: 16),
                _buildServingsField(),
                const SizedBox(height: 16),
                _buildIngredientsField(),
                const SizedBox(height: 16),
                _buildStepsField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                Row(children: <Widget>[Flexible(child: _buildPrepTimeField()), const SizedBox(width: 10), Flexible(child: _buildPrepTimeDropDown())]),
                const SizedBox(height: 16),
                Row(children: <Widget>[Flexible(child: _buildCookTimeField()), const SizedBox(width: 10), Flexible(child: _buildCookTimeDropDown())]),
                MaterialButton(
                    color: Colors.green,
                    child: const Text("Submit", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final isValid = formKey.currentState?.validate();

                      if (isValid == true) {
                        formKey.currentState?.save();

                        Recipe recipe = Recipe(0, _name, image.toString(), _servings, _description, _course, _prepTime, _prepTimeMeasurement,
                            _cookTime, _cookTimeMeasurement);
                        RecipeStep step;
                        Ingredient ingredient;

                        // Insert Recipe to DB
                        int recipeId = await RecipeProvider.createRecipe(recipe);

                        if (recipeId > 0) {
                          // Insert ingredients
                          for (int i = 0; i < _ingredients.length; i++) {
                            ingredient = Ingredient(0, recipeId, _ingredients[i]);
                            await IngredientProvider.createIngredient(ingredient);
                          }

                          // Insert steps
                          for (int i = 0; i < _steps.length; i++) {
                            step = RecipeStep(0, recipeId, i + 1, _steps[i]);
                            await RecipeStepProvider.createRecipeStep(step);
                          }
                        }

                        final message = '$_name has been saved successfully';
                        final snackBar = SnackBar(
                          content: Text(
                            message,
                            style: const TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Colors.orange,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
