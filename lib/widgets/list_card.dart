import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final child;

  const ListCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 200,
        color: Colors.orange,
        child: Center(child: Text(child, style: const TextStyle(fontSize: 40))),
      ),
    );
  }
}
