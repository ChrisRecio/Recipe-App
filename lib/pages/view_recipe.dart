import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/services/models/recipe.dart';

class ViewRecipe extends StatefulWidget {
  final Recipe recipe;
  const ViewRecipe({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() {
    return ViewRecipeState();
  }
}

class ViewRecipeState extends State<ViewRecipe> {
  Widget _buildImageField() {
    String? image = widget.recipe.image;

    return Column(
      children: [image != '' ? Image.file(File(image!)) : const Text("No image")],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildImageField(),
            ],
          ),
        ),
      ),
    );
  }
}
