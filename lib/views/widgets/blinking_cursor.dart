import 'package:currency_converter/service/inherited_properties.dart';
import 'package:flutter/material.dart';

class BlinkingCursor extends StatefulWidget {
  @override
  _BlinkingCursorState createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _controller.repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color cursorColor = InheritedProperties.of(context).accentColor;

    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.linear),
      child: Container(
        height: 40,
        width: 2,
        color: cursorColor,
      ),
    );
  }
}
