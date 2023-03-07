import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../assets/constants.dart';
import '../services/models/recipe.dart';

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
  File? _image;

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    if (widget.recipe.image != null) {
      _image = File(widget.recipe.image!);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.recipe.name}'), centerTitle: true, backgroundColor: Constants.lightRedColor),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
