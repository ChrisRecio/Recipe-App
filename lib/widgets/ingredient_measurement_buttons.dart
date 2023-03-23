import 'package:flutter/material.dart';

import '../assets/constants.dart';

Widget ingredientMeasurementButtons(TextEditingController controller) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "⅛ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "⅛",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "¼ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "¼",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "⅓ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "⅓",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "½ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "½",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "⅔ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "⅔",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: MaterialButton(
            color: Constants.lightBeige,
            onPressed: () => {
              controller.text += "¾ ",
              controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length)),
            },
            child: const Text(
              "¾",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
    ],
  );
}
