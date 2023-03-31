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

import '../assets/constants.dart';
import '../widgets/ingredient_measurement_buttons.dart';
import '../widgets/nav_drawer.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  File? _image;
  late String _name;
  late int _servings;
  late String _description;
  late final int _course = 1;
  late double _prepTime;
  late double _cookTime;
  static const List<String> timeDuration = <String>['Minutes', 'Hours'];
  late String _prepTimeMeasurement = timeDuration.first;
  late String _cookTimeMeasurement = timeDuration.first;
  late List<String> _ingredients;
  late List<String> _steps;

  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final LineSplitter ls = const LineSplitter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
        title: const Text('Add Recipe'),
        backgroundColor: Constants.primaryRed,
        centerTitle: true,
      ),
      drawer: const NavDrawer(),
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
                // const SizedBox(height: 16),
                _buildIngredientsField(),
                const SizedBox(height: 16),
                _buildStepsField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                Row(children: <Widget>[Flexible(child: _buildPrepTimeField()), const SizedBox(width: 10), Flexible(child: _buildPrepTimeDropDown())]),
                const SizedBox(height: 16),
                Row(children: <Widget>[Flexible(child: _buildCookTimeField()), const SizedBox(width: 10), Flexible(child: _buildCookTimeDropDown())]),
                const SizedBox(height: 16),
                MaterialButton(
                    color: Constants.green,
                    child: Text("Submit", style: TextStyle(color: Constants.white, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final isValid = formKey.currentState?.validate();

                      if (isValid == true) {
                        formKey.currentState?.save();

                        Recipe recipe;

                        if (_image == null) {
                          recipe = Recipe(
                              null, _name, null, _servings, _description, _course, _prepTime, _prepTimeMeasurement, _cookTime, _cookTimeMeasurement);
                        } else {
                          recipe = Recipe(null, _name, _image?.path, _servings, _description, _course, _prepTime, _prepTimeMeasurement, _cookTime,
                              _cookTimeMeasurement);
                        }

                        // Insert Recipe to DB
                        int recipeId = await RecipeProvider.createRecipe(recipe);

                        RecipeStep step;
                        Ingredient ingredient;

                        if (recipeId > 0) {
                          // Insert ingredients
                          for (int i = 0; i < _ingredients.length; i++) {
                            ingredient = Ingredient(null, recipeId, _ingredients[i]);
                            await IngredientProvider.createIngredient(ingredient);
                          }

                          // Insert steps
                          for (int i = 0; i < _steps.length; i++) {
                            step = RecipeStep(null, recipeId, i + 1, _steps[i]);
                            await RecipeStepProvider.createRecipeStep(step);
                          }
                        }

                        final message = '$_name has been saved successfully';
                        final snackBar = SnackBar(
                          content: Text(
                            message,
                            style: const TextStyle(fontSize: 20),
                          ),
                          backgroundColor: Constants.primaryRed,
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e'); // REMOVE BEFORE PROD
    }
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e'); // REMOVE BEFORE PROD
    }
  }

  Widget _buildImageField() {
    return Column(
      children: [
        _image != null ? Image.file(_image!) : const Text("No image selected"),
        const SizedBox(height: 5),
        MaterialButton(
            color: Constants.blue,
            child: const Text("Pick Image from Gallery", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImage();
            }),
        MaterialButton(
            color: Constants.blue,
            child: const Text("Pick Image from Camera", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImageCamera();
            }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildNameField() => TextFormField(
        decoration: Constants.textFormFieldDecoration('Name'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the name of the recipe';
          }
          return null;
        },
        onSaved: (value) => setState(() => _name = value!),
      );

  Widget _buildServingsField() => TextFormField(
        decoration: Constants.textFormFieldDecoration('Servings'),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) <= 0) {
            return 'Servings must be greater or equal to 1';
          }
          return null;
        },
        onSaved: (value) => setState(() => _servings = int.parse(value!)),
      );

  Widget _buildIngredientsField() => Column(
        children: [
          ingredientMeasurementButtons(_controller),
          TextFormField(
            decoration: Constants.textFormFieldDecoration('Ingredients'),
            keyboardType: TextInputType.multiline,
            controller: _controller,
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
          ),
        ],
      );

  Widget _buildStepsField() => TextFormField(
        decoration: Constants.textFormFieldDecoration('Steps'),
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
        decoration: Constants.textFormFieldDecoration('Description'),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: (value) => setState(() => _description = value!),
      );
  Widget _buildPrepTimeField() => TextFormField(
        decoration: Constants.textFormFieldDecorationWithIcon('Prep Time', const Icon(Icons.access_time)),
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
        validator: (value) {
          if (value == null || value.isEmpty || double.parse(value) <= 0) {
            return 'Prep Time cannot be negative';
          }
          return null;
        },
        onSaved: (value) => setState(() => _prepTime = double.parse(value!)),
      );

  Widget _buildCookTimeField() => TextFormField(
        decoration: Constants.textFormFieldDecorationWithIcon('Cook Time', const Icon(Icons.access_time)),
        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
        validator: (value) {
          if (value == null || value.isEmpty || double.parse(value) < 0) {
            return 'Cook Time cannot be negative';
          }
          return null;
        },
        onSaved: (value) => setState(() => _cookTime = double.parse(value!)),
      );

  Widget _buildPrepTimeDropDown() => DropdownButton<String>(
        value: _prepTimeMeasurement,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: TextStyle(color: Constants.blue),
        underline: Container(
          height: 2,
          color: Constants.blue,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            _prepTimeMeasurement = value!;
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
        value: _cookTimeMeasurement,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: TextStyle(color: Constants.blue),
        underline: Container(
          height: 2,
          color: Constants.blue,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            _cookTimeMeasurement = value!;
          });
        },
        items: timeDuration.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
}
