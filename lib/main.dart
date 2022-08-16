import 'package:flutter/material.dart';
import 'tempDB.dart';
import 'My Widgets/ListCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'Recipe List'),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  List _recipes = getFoodList();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(itemCount: _recipes.length, itemBuilder: (context, index){

        return ListCard(child: _recipes[index].getName());
        
      }),
    );
  }
}

