import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/ingredient_provider.dart';
import 'package:recipe_app/services/functions/recipe_step_provider.dart';
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
  List<Map<String, dynamic>> _ingredientList = [];
  List<Map<String, dynamic>> _stepList = [];

  bool _isLoading = true;
  void _refreshLists() async {
    final ingredientData = await IngredientProvider.getAllIngredientByRecipeId(widget.recipe.id!);
    final stepData = await RecipeStepProvider.getAllIngredientByRecipeId(widget.recipe.id!);
    setState(() {
      _ingredientList = ingredientData;
      _stepList = stepData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshLists();
  }

  Widget _buildImageField() {
    String? _image = widget.recipe.image;
    // image?.isEmpty ?? true
    return Center(child: (_image?.isNotEmpty ?? true) ? Image.file(File(_image!)) : const Text("No image"));
  }

  Widget _buildServingField() {
    int servings = widget.recipe.servings;
    return Column(children: [
      Text("Servings: $servings"),
    ]);
  }

  Widget _buildTimeField() {
    String prepTimeMeasurement = widget.recipe.prepTimeMeasurement;
    String cookTimeMeasurement = widget.recipe.cookTimeMeasurement;
    int prepTime = widget.recipe.prepTime;
    int cookTime = widget.recipe.cookTime;

    return Row(
      children: [
        const Icon(Icons.access_time),
        Text("Prep time: $prepTime $prepTimeMeasurement"),
        const SizedBox(width: 10),
        const Icon(Icons.access_time),
        Text("Cook time: $cookTime $cookTimeMeasurement"),
      ],
    );
  }

  Widget _buildIngredientField() {
    return Column(
      children: [
        const Text("Ingredients"),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _ingredientList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text('- ${_ingredientList[index]['ingredientName']}'),
                    ))),
      ],
    );
  }

  Widget _buildStepField() {
    return Column(
      children: [
        const Text("Steps"),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _stepList.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text('${_stepList[index]['stepNumber']}. ${_stepList[index]['stepDescription']}'),
                    ))),
      ],
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
        child: ListView(
          children: [
            _buildImageField(),
            const SizedBox(height: 16),
            _buildServingField(),
            const SizedBox(height: 16),
            _buildTimeField(),
            const SizedBox(height: 16),
            _buildIngredientField(),
            const SizedBox(height: 16),
            _buildStepField()
          ],
        ),
      ),
    );
  }
}
