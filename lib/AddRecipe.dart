import 'dart:io';
import 'package:flutter/material.dart';
import 'My Widgets/NavigationDrawer.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
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

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty!';
        }
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

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
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImageField(),
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
                    if (_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState?.save();
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
