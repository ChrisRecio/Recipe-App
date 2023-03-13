import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_app/services/functions/ingredient_provider.dart';
import 'package:recipe_app/services/functions/recipe_step_provider.dart';
import 'package:recipe_app/services/models/recipe.dart';

import '../assets/constants.dart';
import 'edit_recipe.dart';

enum MenuItem {
  share,
  edit,
  delete,
}

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

  Widget _popupMenu() {
    return PopupMenuButton<MenuItem>(
        onSelected: (value) {
          if (value == MenuItem.share) {
          } else if (value == MenuItem.edit) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditRecipe(recipe: widget.recipe),
                ));
          } else if (value == MenuItem.delete) {}
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: MenuItem.share,
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                ),
              ),
              const PopupMenuItem(
                value: MenuItem.edit,
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              ),
              const PopupMenuItem(
                value: MenuItem.delete,
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
              ),
            ]);
  }

  Widget _buildAppBar() {
    String? image = widget.recipe.image;

    if (image != null) {
      return SliverAppBar(
        primary: true,
        pinned: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.35,
        backgroundColor: Colors.white,
        actions: [
          _popupMenu(),
        ],
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: const <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.fadeTitle,
          ],
          centerTitle: true,
          title: Text(
            widget.recipe.name,
            style: const TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,
          ),
          collapseMode: CollapseMode.pin,
          background: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.file(
                File(widget.recipe.image!),
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SliverAppBar(
        pinned: true,
        backgroundColor: Constants.lightRedColor,
        actions: [
          _popupMenu(),
        ],
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(widget.recipe.name),
        ),
      );
    }
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.access_time),
        const SizedBox(width: 5),
        Text("Prep time: $prepTime $prepTimeMeasurement"),
        const SizedBox(width: 20),
        const Icon(Icons.access_time),
        const SizedBox(width: 5),
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
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildServingField(),
              const SizedBox(height: 16),
              _buildTimeField(),
              const SizedBox(height: 16),
              _buildIngredientField(),
              const SizedBox(height: 16),
              _buildStepField(),
            ])),
          ],
        ));
  }
}
