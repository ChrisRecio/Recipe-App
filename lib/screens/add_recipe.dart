import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/recipe.dart';
import '../repository/temp_db.dart';
import '../screens/my_widgets/navigation_drawer.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  File? image;
  late String _name = '';
  late int _servings = 0;
  late List<String> _ingredients;
  late List<String> _steps;
  late String _description;
  final formKey = GlobalKey<FormState>();
  LineSplitter ls = const LineSplitter();

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
            child: const Text("Pick Image from Gallery",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
            onPressed: () {
              pickImage();
            }),
        MaterialButton(
            color: Colors.blue,
            child: const Text("Pick Image from Camera",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold)),
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
        maxLength: 30,
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
                MaterialButton(
                    color: Colors.green,
                    child: const Text("Submit",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      final isValid = formKey.currentState?.validate();

                      if (isValid == true) {
                        formKey.currentState?.save();

                        final int recipesLength = getListLength();
                        Recipe newRecipe = Recipe(
                            recipesLength,
                            _name,
                            "" /*Image.file(image!)*/,
                            _servings,
                            _ingredients,
                            [],
                            '');
                        String temp = newRecipe.getIngredients()[0];
                        print(newRecipe.getIngredients());

                        final message = 'Name: $temp';
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
