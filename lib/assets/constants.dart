import 'package:flutter/material.dart';

class Constants {
  // Color Palette
  static Color primaryRed = const Color.fromARGB(255, 158, 42, 43); // Appbar
  static Color secondaryRed = const Color.fromARGB(255, 185, 117, 109);
  static Color beige = const Color.fromARGB(255, 243, 238, 217); // Background
  static Color lightBeige = const Color.fromARGB(255, 249, 246, 236); // Text Field
  static Color darkBeige = const Color.fromARGB(255, 58, 50, 18); // Text Field Outline
  static Color blue = const Color.fromARGB(255, 0, 91, 174); // Drop Down
  static Color green = const Color.fromARGB(255, 58, 95, 0); // Submit
  static Color white = const Color.fromARGB(255, 255, 255, 255);
  static Color black = const Color.fromARGB(255, 0, 0, 0);

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
