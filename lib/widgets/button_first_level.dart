import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'counter_first_widget.dart';

class ButtonFirstLevel extends StatelessWidget {
  const ButtonFirstLevel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[400],
      child: ButtonWidget(onPressed: () {
        // Call the increment counter function from CounterFirstWidget
        CounterFirstWidget.incrementCounter!();
      }),
    );
  }
}
