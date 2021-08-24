import 'package:currency_converter/data/current_currency.dart';
import 'package:currency_converter/service/converter.dart';
import 'package:currency_converter/views/currency_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Converter converter = BlocProvider.of<Converter>(context);

    Widget currencyText({required String? currency}) => TextButton(
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
            currency ?? "NULL",
            style: TextStyle(
              color: _textColor,
            ),
          ),
        );

    Widget amountText({required double amount}) => Text(
          "${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: _textColor,
          ),
        );

    Text currencyCodeText({required String? code}) => Text(
          code ?? "NULL",
          style: TextStyle(
            color: _textColor,
          ),
        );

    return BlocConsumer<Converter, ConverterState>(
      bloc: converter,
      listener: (context, state) {},
      builder: (context, state) {
        String? currency = converter.getCurrency(_currentCurrency);
        String? code = converter.getCode(_currentCurrency);
        double amount = 100.00;

        return Expanded(
          child: Container(
            color: _color,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                currencyText(currency: currency),
                amountText(amount: amount),
                currencyCodeText(code: code),
              ],
            ),
          ),
        );
      },
    );
  }
}
