import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../assets/constants.dart';
import '../services/functions/ingredient_provider.dart';
import '../services/functions/recipe_provider.dart';
import '../services/functions/recipe_step_provider.dart';
import '../services/models/ingredient.dart';
import '../services/models/recipe.dart';
import '../services/models/recipe_step.dart';
import '../widgets/ingredient_measurement_buttons.dart';

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
  List<String> _ingredientList = [];
  final TextEditingController _ingredientsController =
      TextEditingController(); // Save function
  late final _stepsData; // From DB
  late String _steps; // Names
  List<String> _stepList = []; // Save function
  late String _description;
  late double _prepTime;
  late double _cookTime;
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
    _ingredientData = await IngredientProvider.getAllIngredientsByRecipeId(_id);
    _stepsData = await RecipeStepProvider.getAllRecipeStepsByRecipeId(_id);

    setState(
      () {
        for (int i = 0; i < _ingredientData.length; i++) {
          if (i == _ingredientData.length - 1) {
            _ingredientsController.text += _ingredientData[i]["ingredientName"];
          } else {
            _ingredientsController.text +=
                _ingredientData[i]["ingredientName"] + "\n";
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
      },
    );
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
            color: Constants.blue,
            child: const Text("Pick Image from Gallery",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImage();
            }),
        MaterialButton(
          color: Constants.blue,
          child: const Text("Pick Image from Camera",
              style: TextStyle(
                  color: Colors.white70, fontWeight: FontWeight.bold)),
          onPressed: () {
            pickImageCamera();
          },
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildNameField() => TextFormField(
        initialValue: _name,
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
        initialValue: _servings.toString(),
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

  Widget _buildIngredientsField() => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : Column(
          children: [
            ingredientMeasurementButtons(_ingredientsController),
            TextFormField(
              // initialValue: _ingredients,
              controller: _ingredientsController,
              decoration: Constants.textFormFieldDecoration('Ingredients'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter at least 1 ingredient';
                }
                return null;
              },
              onSaved: (value) => setState(
                () {
                  _ingredientList = ls.convert(value!);
                },
              ),
            ),
          ],
        );

  Widget _buildStepsField() => _isLoading
      ? const Center(child: CircularProgressIndicator())
      : TextFormField(
          initialValue: _steps,
          decoration: Constants.textFormFieldDecoration('Steps'),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter at least 1 step';
            }
            return null;
          },
          onSaved: (value) => setState(
            () {
              _stepList = ls.convert(value!);
            },
          ),
        );

  Widget _buildDescriptionField() => TextFormField(
        initialValue: _description,
        decoration: Constants.textFormFieldDecoration('Description'),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onSaved: (value) => setState(() => _description = value!),
      );

  Widget _buildPrepTimeField() => TextFormField(
        initialValue: _prepTime.toString(),
        decoration: Constants.textFormFieldDecorationWithIcon(
            'Prep Time', const Icon(Icons.access_time)),
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
        validator: (value) {
          if (value == null || value.isEmpty || double.parse(value) <= 0) {
            return 'Prep Time cannot be negative';
          }
          return null;
        },
        onSaved: (value) => setState(() => _prepTime = double.parse(value!)),
      );

  Widget _buildCookTimeField() => TextFormField(
        initialValue: _cookTime.toString(),
        decoration: Constants.textFormFieldDecorationWithIcon(
            'Cook Time', const Icon(Icons.access_time)),
        keyboardType:
            const TextInputType.numberWithOptions(decimal: true, signed: false),
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
          setState(
            () {
              _prepTimeMeasurement = value!;
            },
          );
        },
        items: timeDuration.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.beige,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            // Routing acts strange when swiping back on physical device
            // Must fix
            onPressed: () => Navigator.of(context)
                .pop() /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const ViewRecipeList()),
                (route) => route.isFirst)*/
            , /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewRecipeList()))*/
          ),
          title: Text('Edit $_name'),
          centerTitle: true,
          backgroundColor: Constants.primaryRed),
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
                // const SizedBox(height: 16),
                _buildIngredientsField(),
                const SizedBox(height: 16),
                _buildStepsField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                Row(children: <Widget>[
                  Flexible(child: _buildPrepTimeField()),
                  const SizedBox(width: 10),
                  Flexible(child: _buildPrepTimeDropDown())
                ]),
                const SizedBox(height: 16),
                Row(children: <Widget>[
                  Flexible(child: _buildCookTimeField()),
                  const SizedBox(width: 10),
                  Flexible(child: _buildCookTimeDropDown())
                ]),
                const SizedBox(height: 16),
                MaterialButton(
                    color: Constants.green,
                    child: const Text("Submit",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      final isValid = formKey.currentState?.validate();

                      if (isValid == true) {
                        formKey.currentState?.save();

                        Recipe recipe;

                        if (_image == null) {
                          recipe = Recipe(
                              _id,
                              _name,
                              null,
                              _servings,
                              _description,
                              1,
                              _prepTime,
                              _prepTimeMeasurement,
                              _cookTime,
                              _cookTimeMeasurement);
                        } else {
                          recipe = Recipe(
                              _id,
                              _name,
                              _image?.path,
                              _servings,
                              _description,
                              1,
                              _prepTime,
                              _prepTimeMeasurement,
                              _cookTime,
                              _cookTimeMeasurement);
                        }

                        // Update Recipe
                        await RecipeProvider.updateRecipe(recipe);

                        Ingredient ingredient;
                        RecipeStep step;

                        // UPDATE INGREDIENTS

                        // Compare db to textFormField entries and send to 1 of 3 cases below
                        if (_ingredientList.length == _ingredientData.length) {
                          //same # of ingredients => update each entry

                          for (int i = 0; i < _ingredientList.length; i++) {
                            ingredient = Ingredient(
                                _ingredientData[i]['id'],
                                _ingredientData[i]['recipeId'],
                                _ingredientList[i]);
                            await IngredientProvider.updateIngredient(
                                ingredient);
                          }
                        } else if (_ingredientList.length >
                            _ingredientData.length) {
                          // larger # of ingredients => update each entry + create new entry

                          int itemsInDb = _ingredientData.length;
                          // Loop through entries from input
                          for (int i = 0; i < _ingredientList.length; i++) {
                            if (i < itemsInDb) {
                              // Update existing ingredients
                              ingredient = Ingredient(
                                  _ingredientData[i]['id'],
                                  _ingredientData[i]['recipeId'],
                                  _ingredientList[i]);
                              await IngredientProvider.updateIngredient(
                                  ingredient);
                            } else if (i >= itemsInDb) {
                              // Create new ingredient
                              ingredient = Ingredient(
                                  null,
                                  _ingredientData[0]['recipeId'],
                                  _ingredientList[i]);
                              await IngredientProvider.createIngredient(
                                  ingredient);
                            }
                          }
                        } else if (_ingredientList.length <
                            _ingredientData.length) {
                          // if lower # of ingredients => update each entry + delete extras

                          int itemsInInput = _ingredientList.length;
                          // Loop through entries from database
                          for (int i = 0; i < _ingredientData.length; i++) {
                            if (i < itemsInInput) {
                              // Update existing ingredients
                              ingredient = Ingredient(
                                  _ingredientData[i]['id'],
                                  _ingredientData[i]['recipeId'],
                                  _ingredientList[i]);
                              await IngredientProvider.updateIngredient(
                                  ingredient);
                            } else if (i >= itemsInInput) {
                              // Delete ingredient if greater than # in input
                              await IngredientProvider.deleteIngredient(
                                  _ingredientData[i]['id']);
                            }
                          }
                        } else {
                          // probably add a better error message
                          print(
                              "if you're here then you win\nnot sure what to tell you");
                        }

                        // UPDATE RECIPE STEPS

                        // Compare db to textFormField entries and send to 1 of 3 cases below
                        if (_stepList.length == _stepsData.length) {
                          //same # of steps => update each entry

                          for (int i = 0; i < _stepList.length; i++) {
                            step = RecipeStep(_stepsData[i]['id'],
                                _stepsData[i]['recipeId'], i + 1, _stepList[i]);
                            await RecipeStepProvider.updateRecipeStep(step);
                          }
                        } else if (_stepList.length > _stepsData.length) {
                          // larger # of steps => update each entry + create new entry

                          int itemsInDb = _stepsData.length;
                          // Loop through entries from input
                          for (int i = 0; i < _stepList.length; i++) {
                            if (i < itemsInDb) {
                              // Update existing ingredients
                              step = RecipeStep(
                                  _stepsData[i]['id'],
                                  _stepsData[i]['recipeId'],
                                  i + 1,
                                  _stepList[i]);
                              await RecipeStepProvider.updateRecipeStep(step);
                            } else if (i >= itemsInDb) {
                              // Create new ingredient
                              step = RecipeStep(null, _stepsData[0]['recipeId'],
                                  i + 1, _stepList[i]);
                              await RecipeStepProvider.createRecipeStep(step);
                            }
                          }
                        } else if (_stepList.length < _stepsData.length) {
                          // if lower # of steps => update each entry + delete extras

                          int itemsInInput = _ingredientList.length;
                          // Loop through entries from database
                          for (int i = 0; i < _ingredientData.length; i++) {
                            if (i < itemsInInput) {
                              // Update existing ingredients
                              step = RecipeStep(
                                  _stepsData[i]['id'],
                                  _stepsData[i]['recipeId'],
                                  i + 1,
                                  _stepList[i]);
                              await RecipeStepProvider.updateRecipeStep(step);
                            } else if (i >= itemsInInput) {
                              // Delete ingredient if greater than # in input
                              await IngredientProvider.deleteIngredient(
                                  _stepsData[i]['id']);
                            }
                          }
                        } else {
                          // probably add a better error message
                          print(
                              "if you're here then you win\nnot sure what to tell you");
                        }

                        final message = '$_name has been updated';
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
}
