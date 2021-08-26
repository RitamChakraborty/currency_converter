import 'package:currency_converter/data/current_currency.dart';
import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  const Amount({
    required Color color,
    required Color textColor,
    required CurrentCurrency currentCurrency,
    Key? key,
  })  : this._color = color,
        this._textColor = textColor,
        this._currentCurrency = currentCurrency,
        super(key: key);

  final Color _color;
  final Color _textColor;
  final CurrentCurrency _currentCurrency;

  @override
  Widget build(BuildContext context) {
    List<Widget> digitBtns = [
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
      CircleAvatar(),
    ];

    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: GridView.builder(
          itemCount: digitBtns.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
          ),
          itemBuilder: (context, index) {
            return digitBtns[index];
          },
        ),
      ),
    );
  }
}
