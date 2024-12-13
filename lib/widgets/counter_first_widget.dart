import 'package:flutter/material.dart';
import 'counter_widget.dart';

class CounterFirstWidget extends StatefulWidget {
  const CounterFirstWidget({Key? key}) : super(key: key);

  static void Function()? incrementCounter; // Nullable static reference to increment function

  @override
  _CounterFirstWidgetState createState() => _CounterFirstWidgetState();
}

class _CounterFirstWidgetState extends State<CounterFirstWidget> {
  int _counter = 28;

  @override
  void initState() {
    super.initState();
    // Set the static method to increment the counter
    CounterFirstWidget.incrementCounter = _incrementCounter;
  }

  // Method to increment the counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent[200],
      child: CounterWidget(counter: _counter), // Display the updated counter
    );
  }
}
