import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: MaterialButton(
        color: Colors.blue[300],
        onPressed: onPressed, // Trigger the onPressed callback passed from ButtonFirstLevel
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
