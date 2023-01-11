import 'dart:io';
import 'package:flutter/material.dart';
import '../bloc/recipe.dart';
import '../repository/temp_db.dart';
import '../screens/my_widgets/navigation_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});


  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  File? image;
  String _name = '';
  late List _ingredients;
  late List _steps;
  late String _description;
  final formKey = GlobalKey<FormState>();

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


  Widget _buildIngredientsField() {
    return TextFormField();
  }

  Widget _buildStepsField() {
    return TextFormField();
  }

  Widget _buildDescriptionField() {
    return TextFormField();
  }

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
                // _buildIngredientsField(),
                // _buildStepsField(),
                // _buildDescriptionField(),
                const SizedBox(height: 100),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {

                    final isValid = formKey.currentState?.validate();

                    if(isValid == true){
                      formKey.currentState?.save();

                      final int recipesLength = getListLength();
                      recipe newRecipe = recipe(recipesLength, _name, Image.asset('assets/images/default.jpg'), [], [], '');
                      String temp = newRecipe.getName();

                      final message = 'Name: $temp';
                      final snackBar = SnackBar(content: Text(
                        message,
                        style: const TextStyle(fontSize: 20),
                      ),
                        backgroundColor: Colors.orange,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }


                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
