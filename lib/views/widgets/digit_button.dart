import 'package:flutter/material.dart';

class DigitButton extends StatelessWidget {
  const DigitButton({
    required String text,
    required Color color,
    required Color textColor,
    required Widget child,
    required VoidCallback onPressed,
    Key? key,
  })  : this._text = text,
        this._color = color,
        this._textColor = textColor,
        this._child = child,
        this._onPressed = onPressed,
        super(key: key);

  final String _text;
  final Color _color;
  final Color _textColor;
  final Widget _child;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
        backgroundColor: _color,
        heroTag: _text,
        child: _child,
        onPressed: _onPressed,
      ),
    );
  }
}
