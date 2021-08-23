import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  final Color _color;

  const CurrencyWidget({required Color color, Key? key})
      : this._color = color,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: _color,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("EURO"),
            Text("100.00"),
            Text("EUR"),
          ],
        ),
      ),
    );
  }
}
