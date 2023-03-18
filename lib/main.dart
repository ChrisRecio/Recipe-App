import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home.dart';

import '../assets/constants.dart';

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
          // fontFamily: '',
          primarySwatch: Constants.getMaterialColor(Constants.darkBeige),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Constants.darkBeige,
            selectionColor: Constants.textHighlightRed,
            selectionHandleColor: Constants.secondaryRed,
          )),
      home: HomePage(),
    );
  }
}
