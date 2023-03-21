import 'package:flutter/material.dart';

class Constants {
  // Trending Recipe API URL
  // TODO
  // CHANGE URL TO API ONCE COMPLETED
  static String apiURL = "https://jsonplaceholder.typicode.com/albums/1";

  // Color Palette
  static Color primaryRed = const Color.fromARGB(255, 158, 42, 43); // Appbar
  static Color secondaryRed = const Color.fromARGB(255, 185, 117, 109);
  static Color textHighlightRed = const Color.fromARGB(255, 228, 154, 156);
  static Color beige = const Color.fromARGB(255, 243, 238, 217); // Background
  static Color lightBeige = const Color.fromARGB(255, 249, 246, 236); // Text Field
  static Color darkBeige = const Color.fromARGB(255, 58, 50, 18); // Text Field Outline
  static Color blue = const Color.fromARGB(255, 0, 91, 174); // Drop Down
  static Color green = const Color.fromARGB(255, 58, 95, 0); // Submit
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color black = const Color.fromARGB(255, 0, 0, 0);

  // Convert Color to MaterialColor
  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  // TextFormField Constants
  static InputDecoration textFormFieldDecoration(String name) => InputDecoration(
      labelText: name,
      labelStyle: TextStyle(color: darkBeige),
      filled: true,
      fillColor: lightBeige,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.darkBeige, width: 2.0),
      ),
      border: const OutlineInputBorder(borderSide: BorderSide()));

  static InputDecoration textFormFieldDecorationWithIcon(String name, Icon icon) => InputDecoration(
      labelText: name,
      prefixIcon: icon,
      labelStyle: TextStyle(color: darkBeige),
      filled: true,
      fillColor: lightBeige,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.darkBeige, width: 2.0),
      ),
      border: const OutlineInputBorder(borderSide: BorderSide()));
}
