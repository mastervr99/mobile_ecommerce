import 'package:flutter/material.dart';

class Circular_Progress_Widget extends StatefulWidget {
  @override
  _Circular_Progress_Widget_State createState() =>
      _Circular_Progress_Widget_State();
}

class _Circular_Progress_Widget_State extends State<Circular_Progress_Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
