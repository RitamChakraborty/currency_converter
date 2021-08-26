import 'package:flutter/material.dart';

class DigitButton extends StatelessWidget {
  const DigitButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    Key? key,
  })  : this._text = text,
        this._color = color,
        this._textColor = textColor,
        this._onPressed = onPressed,
        super(key: key);

  final String _text;
  final Color _color;
  final Color _textColor;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
        backgroundColor: _color,
        child: Text(
          _text,
          style: TextStyle(
            fontSize: 24,
            color: _textColor,
          ),
        ),
        onPressed: _onPressed,
      ),
    );
  }
}
