import 'package:flutter/material.dart';
import 'My Widgets/NavigationDrawer.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddRecipeState();
  }
}

class AddRecipeState extends State<AddRecipe> {
  late String _name;
  late Image _image;
  late List _ingredients;
  late List _steps;
  late String _description;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField();
  }

  Widget _buildImageField() {
    return TextFormField();
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
        margin: EdgeInsets.all(24),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNameField(),
              _buildImageField(),
              _buildIngredientsField(),
              _buildStepsField(),
              _buildDescriptionField(),
              const SizedBox(height: 100),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () => { },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
