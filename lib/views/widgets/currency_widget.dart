import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/views/currency_selector.dart';
import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  final Color _color;
  final Color _textColor;
  final CurrentCurrency _currentCurrency;

  const CurrencyWidget({
    required Color color,
    required Color textColor,
    required CurrentCurrency currentCurrency,
    Key? key,
  })  : this._color = color,
        this._textColor = textColor,
        this._currentCurrency = currentCurrency,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget currencyText = TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CurrencySelector(
              color: _color,
              textColor: _textColor,
              currentCurrency: _currentCurrency,
            ),
          ),
        );
      },
      child: Text(
        "EURO",
        style: TextStyle(
          color: _textColor,
        ),
      ),
    );

    final Widget amountText = Text(
      "100.00",
      style: TextStyle(
        color: _textColor,
      ),
    );

    final Text currencyCodeText = Text(
      "EUR",
      style: TextStyle(
        color: _textColor,
      ),
    );

    return Expanded(
      child: Container(
        color: _color,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            currencyText,
            amountText,
            currencyCodeText,
          ],
        ),
      ),
    );
  }
}
