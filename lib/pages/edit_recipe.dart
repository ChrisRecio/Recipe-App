import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/pages/view_recipe_list.dart';

import '../assets/constants.dart';
import '../services/functions/ingredient_provider.dart';
import '../services/functions/recipe_provider.dart';
import '../services/functions/recipe_step_provider.dart';
import '../services/models/ingredient.dart';
import '../services/models/recipe.dart';
import '../services/models/recipe_step.dart';

class EditRecipe extends StatefulWidget {
  final Recipe recipe;
  const EditRecipe({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() {
    return EditRecipeState();
  }
}

class EditRecipeState extends State<EditRecipe> {
  // Variables
  final formKey = GlobalKey<FormState>();

  late int _id;
  File? _image;
  late String _name;
  late int _servings;
  late final _ingredientData; // From DB
  late String _ingredients; // Names
  List<String> _ingredientList = []; // Save function
  late final _stepsData; // From DB
  late String _steps; // Names
  List<String> _stepList = []; // Save function
  late String _description;
  late int _prepTime;
  late int _cookTime;
  static const List<String> timeDuration = <String>['Minutes', 'Hours'];
  late String _prepTimeMeasurement = timeDuration.first;
  late String _cookTimeMeasurement = timeDuration.first;

  final LineSplitter ls = const LineSplitter();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() async {
    if (widget.recipe.image != null) {
      _image = File(widget.recipe.image!);
    }
    _id = widget.recipe.id!;
    _name = widget.recipe.name;
    _servings = widget.recipe.servings;
    _description = widget.recipe.description;
    _prepTime = widget.recipe.prepTime;
    _prepTimeMeasurement = widget.recipe.prepTimeMeasurement;
    _cookTime = widget.recipe.cookTime;
    _cookTimeMeasurement = widget.recipe.cookTimeMeasurement;
    _ingredientData = await IngredientProvider.getAllIngredientByRecipeId(_id);
    _stepsData = await RecipeStepProvider.getAllRecipeStepsByRecipeId(_id);
    print(_stepsData);

    setState(() {
      _ingredients = "";
      for (int i = 0; i < _ingredientData.length; i++) {
        if (i == _ingredientData.length - 1) {
          _ingredients += _ingredientData[i]["ingredientName"];
        } else {
          _ingredients += _ingredientData[i]["ingredientName"] + "\n";
        }
      }

      _steps = "";
      for (int i = 0; i < _stepsData.length; i++) {
        if (i == _stepsData.length - 1) {
          _steps += "${_stepsData[i]["stepDescription"]}";
        } else {
          _steps += "${_stepsData[i]["stepDescription"]}\n";
        }
      }
      _isLoading = false;
    });
  }

  // Pick image from gallery
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

  // Capture image
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

  // Display image
  Widget _buildImageField() {
    return Column(
      children: [
        _image != null ? Image.file(_image!) : const Text("No image selected"),
        const SizedBox(height: 5),
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
              pickImageCamera();
            }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildNameField() => TextFormField(
        initialValue: _name,
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
        initialValue: _servings.toString(),
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

  Widget _buildIngredientsField() => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : TextFormField(
          initialValue: _ingredients,
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
            _ingredientList = ls.convert(value!);
          }),
        );

  Widget _buildStepsField() => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : TextFormField(
          initialValue: _steps,
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
            _stepList = ls.convert(value!);
          }),
        );

  Widget _buildDescriptionField() => TextFormField(
        initialValue: _description,
        decoration: const InputDecoration(
          labelText: 'Description',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: (value) => setState(() => _description = value!),
      );

  Widget _buildPrepTimeField() => TextFormField(
        initialValue: _prepTime.toString(),
        decoration: const InputDecoration(
          labelText: 'Prep Time',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) <= 0) {
            return 'Prep Time cannot be negative';
          }
          return null;
        },
        onSaved: (value) => setState(() => _prepTime = int.parse(value!)),
      );

  Widget _buildCookTimeField() => TextFormField(
        initialValue: _cookTime.toString(),
        decoration: const InputDecoration(
          labelText: 'Cook Time',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) < 0) {
            return 'Cook Time cannot be negative';
          }
          return null;
        },
        onSaved: (value) => setState(() => _cookTime = int.parse(value!)),
      );

  Widget _buildPrepTimeDropDown() => DropdownButton<String>(
        value: _prepTimeMeasurement,
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
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewRecipeList())).whenComplete(initState),
          ),
          title: Text('Edit $_name'),
          centerTitle: true,
          backgroundColor: Constants.lightRedColor),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                const SizedBox(height: 16),
                MaterialButton(
                    color: Colors.green,
                    child: const Text("Submit", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final isValid = formKey.currentState?.validate();

                      if (isValid == true) {
                        formKey.currentState?.save();

                        Recipe recipe;

                        if (_image == null) {
                          recipe =
                              Recipe(_id, _name, null, _servings, _description, 1, _prepTime, _prepTimeMeasurement, _cookTime, _cookTimeMeasurement);
                        } else {
                          recipe = Recipe(
                              _id, _name, _image?.path, _servings, _description, 1, _prepTime, _prepTimeMeasurement, _cookTime, _cookTimeMeasurement);
                        }

                        // Update Recipe
                        await RecipeProvider.updateRecipe(recipe);

                        RecipeStep step;
                        Ingredient ingredient;

                        // id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, ingredientName TEXT NOT NULL, FOREIGN KEY(recipeId) REFERENCES Recipe(id))
                        // id INTEGER NOT NULL PRIMARY KEY autoincrement, recipeId INTEGER NOT NULL, stepNumber INTEGER NOT NULL, stepDescription TEXT, FOREIGN KEY(recipeId) REFERENCES Recipe(id))

                        //ingredientData = Data from DB
                        //[{id: 1, recipeId: 1, ingredientName: Bread}, {id: 2, recipeId: 1, ingredientName: Cheese}, {id: 3, recipeId: 1, ingredientName: Ham}]
                        //_ingredientList = Data from TextFormField

                        //stepsData = Data from DB
                        //[{id: 1, recipeId: 1, stepNumber: 1, stepDescription: Take 2 pieces of bread}, {id: 2, recipeId: 1, stepNumber: 2, stepDescription: Place cheese and ham on top of 1 slice of bread}, {id: 3, recipeId: 1, stepNumber: 3, stepDescription: Place 2nd slice of bread over ham and cheese}]
                        //_stepList = Data from TextFormField

                        // Compare db to textFormField entries and send to 1 of 3 cases below
                        if (_ingredientList.length == _ingredientData.length) {
                          //same # of ingredients/steps => update each entry
                          for (int i = 0; i < _ingredientList.length; i++) {
                            ingredient = Ingredient(_ingredientData[i]['id'], _ingredientData[i]['recipeId'], _ingredientList[i]);
                            await IngredientProvider.updateIngredient(ingredient);
                          }
                        } else if (_ingredientList.length > _ingredientData.length) {
                          // larger # of ingredients/steps => update each entry + create new entry
                        } else if (_ingredientList.length < _ingredientData.length) {
                          // if lower # of ingredients/steps => update each entry + delete extras
                        } else {
                          print("if you're here then you win\nnot sure what to tell you");
                        }

                        // Insert ingredients
/*
                        for (int i = 0; i < _ingredientList.length; i++) {
                          ingredient = Ingredient(null, _id, _ingredients[i]);
                          await IngredientProvider.createIngredient(ingredient);
                        }

                        // Insert steps
                        for (int i = 0; i < _stepList.length; i++) {
                          step = RecipeStep(null, _id, i + 1, _steps[i]);
                          await RecipeStepProvider.createRecipeStep(step);
                        }
*/

                        final message = '$_name has been updated';
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
